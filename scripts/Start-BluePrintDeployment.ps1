param(
    [Parameter(Mandatory=$false)]
    $BluePrintFolder =".\AzBluePrints",

    [Parameter(Mandatory=$false)]
    $removeExistingAssignments = $false
)

$errorActionPreference = "stop"

#Importing required Modules
try {
    Import-Module Az.BluePrint
    #Import-Module Az.Accounts
}
Catch{
    # Install-Module -Name Az.Accounts -Repository PSGallery -AllowClobber -Force -Verbose
    # Uninstall-AzureRM
    # Write-Host "Successfully installed Az module"

    Install-Module -Name Az.Blueprint -AllowClobber -RequiredVersion 0.2.5 -Force -Verbose
    Write-Host "Successfully installed Az.Blueprint module"

    Import-Module -Name Az.Accounts -Global
    Import-Module -Name Az.Blueprint -Global
}

Write-Host "See which sub we've got with this SPN"
Get-azContext


#Read assignment json
$assignments = (Get-Content "$blueprintFolder\assignments.json" | ConvertFrom-Json).bluePrintAssignments
$subscriptions = Get-AzSubscription
#check for removed blueprint assignments
foreach($sub in $subscriptions){    
    [array]$bluePrintAssignments += Get-AzBlueprintAssignment -SubscriptionId $sub.Id
}
if($bluePrintAssignments){
    foreach($bluePrintAssignment in $bluePrintAssignments){
        if(($assignments | Where-Object {(($_.bluePrintDefinitionName -eq ($bluePrintAssignment.Name).Replace("Assignment-","")) -and ($_.bluePrintVersion -eq ($bluePrintAssignment.BlueprintId).Split("/")[(($bluePrintAssignment.BlueprintId).Split("/").count -1)]) -and ($_.subscriptionId -eq (($bluePrintAssignment.Scope).Replace("/subscriptions/",""))))})){
            Write-Host "Assignment $($bluePrintAssignment.Name) still exists!"
            $bluePrintAssignment
        }else{
            Write-Host "Assignment $($bluePrintAssignment.Name) needs to be removed!"
            if($removeExistingAssignments -eq $true){
                Remove-AzBlueprintAssignment -Name $bluePrintAssignment.Name -Subscription ($bluePrintAssignment.Scope).Replace("/subscriptions/","")
            }else{
                Write-Host "Skipping the removal of this Blueprint!"
            }
        }
    }
}

#set or append blueprints
Foreach ($bp in $assignments) {

    $bluePrintName = $bp.bluePrintDefinitionName
    $subscriptionId = $bp.subscriptionId
    Write-Host "working on $bluePrintName in $($bp.subscriptionId)"
    if($bp.scopeType -eq "managementGroup"){
        $bluePrintObject = Get-AzBlueprint -ManagementGroupId $bp.scopeId -Name $blueprintName -Version $bp.bluePrintVersion -ErrorAction SilentlyContinue
    }else{
        $bluePrintObject = Get-AzBlueprint -SubscriptionId $bp.scopeId -Name $blueprintName -Version $bp.bluePrintVersion -ErrorAction SilentlyContinue
    }

    if($bluePrintObject){
        #Get the parameters for the blueprint assignment
        $params = $null
        $rgArray = $null
        if($bp.parametersFile){
            . "$BluePrintFolder\$bluePrintName\$($bp.parametersFile)"
        }else{
            . "$BluePrintFolder\parameters.ps1"
        }

        # Generate the assignment name
        $generatedAssignmentName = "Assignment-$blueprintName" 

        # check to see if there is an existing assignment
        $oldAssignment = Get-AzBlueprintAssignment -SubscriptionId $subscriptionId -Name $generatedAssignmentName -ErrorAction silentlycontinue

        if ($oldAssignment) {
            Write-Host "Updating existing assignment..."
            If ($rgArray) {
                Set-AzBlueprintAssignment -Name $generatedAssignmentName -Blueprint $bluePrintObject -Location $location -SystemAssignedIdentity -lock $lockMode -ResourceGroupParameter $rgArray -Parameter $params
            }
            else {
                Set-AzBlueprintAssignment -Name $generatedAssignmentName -Blueprint $bluePrintObject -Location $location -SystemAssignedIdentity -lock $lockMode -Parameter $params
            }
        } else {
            Write-Host "Creating new assignment..."
            If ($rgArray) {
                New-AzBlueprintAssignment -Blueprint $bluePrintObject -Location $location -SubscriptionId $subscriptionId -Parameter $params -ResourceGroupParameter $rgArray -Name $generatedAssignmentName -SystemAssignedIdentity -Lock $lockMode
            }
            else {
                New-AzBlueprintAssignment -Blueprint $bluePrintObject -Location $location -SubscriptionId $subscriptionId -Parameter $params -Name $generatedAssignmentName -SystemAssignedIdentity -Lock $lockMode -Verbose
            }
        }

        # Check the status of the blueprint assignment
        $assignment = Get-AzBlueprintAssignment -Subscription $subscriptionId -Name $generatedAssignmentName -ErrorAction SilentlyContinue
        $counter = 0 
        if($assignment){
            while (($assignment.ProvisioningState -ne "Succeeded") -and ($assignment.ProvisioningState -ne "Failed")) {
                Write-Host $assignment.ProvisioningState
                Start-Sleep -Seconds 5
                $assignment = Get-AzBlueprintAssignment -Subscription $subscriptionId -Name $generatedAssignmentName
                $counter++
            }

            # Take action based on terminal assignment state
            if ($assignment.ProvisioningState -eq "Succeeded") {
                Write-Host "Success" -ForegroundColor Green
                Write-Host $response # need to check this and fail accordingly
            } elseif ($assignment.provisioningState -eq "Failed") {
                Write-Host "Failure message" # todo - find out where the error message is in the assignment object and output it
                throw "Assignment failed to deploy"
                exit 1
            } else {
                throw "Unhandled terminal state for assignment: {0}" -f $assignment.ProvisioningState 
                exit 1
            }
        }else{
            Write-Host "Assignment $generatedAssignmentName couldn't be found!"
        }
    }else{
        Write-Host "Blueprint $BluePrintName with Version $($bp.bluePrintVersion) couldn't be found!"
    }
}

