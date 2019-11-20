param(
[Parameter(mandatory=$false)]
$BluePrintFolder =".\AzBluePrints"
)

$errorActionPreference = "stop"

#Importing required Modules
try {
    Install-Module -Name Az.Blueprint -RequiredVersion 0.2.5 -Force 
}
Catch{
    write-warning $_.Exception
}
Import-Module Az.BluePrint -RequiredVersion 0.2.5 -Global

Write-Host "See which sub we've got with this SPN"
Get-azContext


# Get token for API requests
Write-Host "Getting Azure token"
$azContext = Get-AzContext
$azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($azProfile)
$token = $profileClient.AcquireAccessToken($azContext.Tenant.Id)
$authHeader = @{
    'Content-Type'='application/json'
    'Authorization'='Bearer ' + $token.AccessToken
}
Write-Host "Got Token"

#replace Management Group Id or Subscription Id for custom policies first
$customPolicies = Get-ChildItem -Path "$BluePrintFolder" -Filter "*.json" -Recurse -Verbose

Foreach ($pol in $customPolicies) {
    Write-Host "working on $($pol.FullName)"
    $Artifact = get-content -Path $pol.FullName | ConvertFrom-Json
    if($Artifact.properties.policyDefinitionId){
        $policyGUID = $Artifact.properties.policyDefinitionId.Split("/")[(($Artifact.properties.policyDefinitionId).Split("/").count -1)]
        if($Artifact.properties.policyDefinitionId -like "*policySetDefinitions*"){
            $azPol = Get-AzPolicySetDefinition | Where-Object {$_.policysetDefinitionId -like "*$policyGUID*"}
        }else{
            $azPol = Get-AzPolicyDefinition | Where-Object {$_.policyDefinitionId -like "*$policyGUID*"}
        }
        if($azPol){
            write-host "Preparing Policy $policyGUID"
            $Artifact.properties.policyDefinitionId = $azPol.ResourceId
            $ArtifactNew = $Artifact | ConvertTo-Json -Depth 20 | ForEach-Object{
                [Regex]::Replace($_, 
                    "\\u(?<Value>[a-zA-Z0-9]{4})", {
                        param($m) ([char]([int]::Parse($m.Groups['Value'].Value,
                            [System.Globalization.NumberStyles]::HexNumber))).ToString() } )}

            Set-Content -Value $ArtifactNew -Path $pol.FullName
        }else{
            write-host "There is no policy with the name $policyGUID. Please make sure the policy exists on Azure and run the script again."
            exit
        }
    }
}



#get blueprint definitions from json    
$bluePrintDefinitions = (Get-Content -Path "$BluePrintFolder\definitions.json" | ConvertFrom-Json).bluePrintDefinitions

#check for removed blueprints
$bluePrints = Get-AzBlueprint
$removedBluePrints = $null

$subBluePrintsReference = ($bluePrints | Where-Object {$_.ManagementGroupId -eq $null})
$subBluePrintsDifference = ($bluePrintDefinitions | Where-Object {$_.scopeType -eq "Subscription"})
if($subBluePrintsReference -and $subBluePrintsDifference){
    $Difference += Compare-Object -ReferenceObject $subBluePrintsReference.name -DifferenceObject $subBluePrintsDifference.bluePrintDefinitionName | Where-Object {$_.SideIndicator -eq "<="}
    foreach($diff in $Difference){
        $subBluePrintsReference | Where-Object {$_.name -eq $diff.Inputobject} | ForEach-Object{
            $removedBluePrints += $_
        }
    }
}

$magBluePrintsReference = ($bluePrints | Where-Object {$_.ManagementGroupId -ne $null})
$magBluePrintsDifference = ($bluePrintDefinitions | Where-Object {$_.scopeType -eq "managementGroup"})
if($magBluePrintsReference -and $magBluePrintsDifference){
    $Difference += Compare-Object -ReferenceObject $magBluePrintsReference.name -DifferenceObject $magBluePrintsDifference.bluePrintDefinitionName | Where-Object {$_.SideIndicator -eq "<="}
    foreach($diff in $Difference){
        $magBluePrintsReference | Where-Object {$_.name -eq $diff.Inputobject} | ForEach-Object{
            $removedBluePrints += $_
        }
    }
}

If($removedBluePrints){
    Foreach ($toRemoveBP in $removedBluePrints){
        Write-Host "Blueprint to be removed: $($toRemoveBP.Inputobject)"
        if($null -eq $toRemoveBP.ManagementGroupId){
                # Remove the Blueprint with REST API
            $url = "https://management.azure.com/subscriptions/{0}/providers/Microsoft.Blueprint/blueprints/{1}?api-version=2018-11-01-preview" -f $($toRemoveBP.subscription), $($toRemoveBP.name)
            write-host $url
        }else{
                # Remove the Blueprint with REST API
            $url = "https://management.azure.com/providers/Microsoft.Management/managementGroups/{0}/providers/Microsoft.Blueprint/blueprints/{1}?api-version=2018-11-01-preview" -f $($toRemoveBP.ManagementGroupId), $($toRemoveBP.name)
            write-host $url
        }
        # Invoke the REST API
        $response = Invoke-RestMethod -Uri $url -Method DELETE -Headers $authHeader
        Write-Host $response
    }
}

#newer and non existent definitions 
$bluePrintNamesManagementGroup = @()
$bluePrintNamesSubscription = @()
$bluePrintObjects = @()

Foreach ($bluePrintDefinition in $bluePrintDefinitions) {
    if($bluePrintDefinition.scopeType -eq "managementGroup"){
        $bluePrintObject = Get-AzBlueprint -ManagementGroupId $bluePrintDefinition.scopeId -Name $bluePrintDefinition.bluePrintDefinitionName -LatestPublished -ErrorAction SilentlyContinue
        if($bluePrintObject){
            If([version]$bluePrintDefinition.bluePrintVersion -ne [version]$bluePrintObject.Version){
                Write-Host "Another Blueprint definition version exists for Blueprint $($bluePrintDefinition.bluePrintDefinitionName). Actual version: $($bluePrintObject.Version), this version: $($bluePrintDefinition.bluePrintVersion)"
                $bluePrintNamesManagementGroup += $bluePrintDefinition
            }
        }else{
            Write-Host "New Blueprint (ManagementGroup): $($bluePrintDefinition.bluePrintDefinitionName)"
            $bluePrintNamesManagementGroup += $bluePrintDefinition
        }
    }else{
        $bluePrintObject = Get-AzBlueprint -Name $bluePrintDefinition.bluePrintDefinitionName -LatestPublished -ErrorAction SilentlyContinue

        if($bluePrintObject){
            If([version]$bluePrintDefinition.bluePrintVersion -ne [version]$bluePrintObject.Version){
                Write-Host "Another Blueprint definition version exists for Blueprint $($bluePrintDefinition.bluePrintDefinitionName). Actual version: $($bluePrintObject.Version), this version: $($bluePrintDefinition.bluePrintVersion)"
                $bluePrintNamesSubscription += $bluePrintDefinition
            }
        }else{
            Write-Host "New Blueprint (Subscription): $($bluePrintDefinition.bluePrintDefinitionName)"
            $bluePrintNamesSubscription += $bluePrintDefinition
        }
    }
    $bluePrintObjects = $bluePrintNamesManagementGroup
    $bluePrintObjects += $bluePrintNamesSubscription
}

#import & publish
Foreach ($bp in $bluePrintObjects) {
    Write-Host "Start Blueprint import: $($bp.bluePrintDefinitionName)"
    if(Test-Path "$BluePrintFolder\$($bp.bluePrintDefinitionName)\"){
        if($bp.scopeType -eq "managementGroup"){
            $artifacts = Get-ChildItem -Path "$BluePrintFolder\$($bp.bluePrintDefinitionName)\Artifacts" -Recurse
            foreach($artifact in $artifacts){
                $polContent = Get-Content -Path $artifact.FullName 
                If ($polContent -match 'managementgroups') {
                    #$newPolContent = $polContent -replace '/managementgroups/.*/providers',"/managementgroups/$($bp.scopeID)/providers"
                    #Set-Content -Path $artifact.FullName -Value $newPolContent -Force
                }
                If ($polContent -match 'subscriptions') {
                    #$newPolContent = $polContent -replace '/subscriptions/.*/providers',"/subscriptions/$($bp.scopeID)/providers"
                    #Set-Content -Path $artifact.FullName -Value $newPolContent -Force
                }
            }
            Import-AzBlueprintWithArtifact -Name $bp.bluePrintDefinitionName -ManagementGroupId $bp.scopeID -InputPath "$BluePrintFolder\$($bp.bluePrintDefinitionName)\" -Force -Verbose
            $thisBluePrint = Get-AzBlueprint -Name $bp.bluePrintDefinitionName -ManagementGroupId $bp.scopeID
            Publish-AzBlueprint -Blueprint $thisBluePrint -Version $bp.bluePrintVersion
        }else{
            Import-AzBlueprintWithArtifact -Name $bp.bluePrintDefinitionName -SubscriptionId $bp.scopeID -InputPath  "$BluePrintFolder\$($bp.bluePrintDefinitionName)\" -Force -Verbose
            $thisBluePrint = Get-AzBlueprint -Name $bp.bluePrintDefinitionName -SubscriptionId $bp.scopeID
            Publish-AzBlueprint -Blueprint $thisBluePrint -Version $bp.bluePrintVersion
        }
    }else{
        write-host "Folder `"$BluePrintFolder\$($bp.bluePrintDefinitionName)\`" couldn't be found."
    }

    # success       
    if ($?) {
        Write-Host "Blueprint and it's artifact Imported successfully" -ForegroundColor Green
    } else {
        throw "Failed to import blueprint: $($bp.name)"
        exit 1
    }

}
