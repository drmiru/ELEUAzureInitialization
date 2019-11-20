#location for MSI
$location = "westeurope"

#AssignmentScope
$scope = "p-mag-root"

#parameters for initiatives
$params = @{
requirespecifiedtagonresourcegroups_TAGNAME_1 = "Environment"
requirespecifiedtagonresourcegroups_TAGNAME_2 = "Service"
requirespecifiedtagonresourcegroups_TAGNAME_3 = "Owner"
requirespecifiedtagonresourcegroups_TAGNAME_4 = "OwnerApp"
requirespecifiedtagonresourcegroups_TAGNAME_5 = "Notes"
requirespecifiedtagonresourcegroups_effect_1 = "Deny"
requirespecifiedtagonresourcegroups_effect_2 = "Deny"
requirespecifiedtagonresourcegroups_effect_3 = "Deny"
requirespecifiedtagonresourcegroups_effect_4 = "Disabled"
requirespecifiedtagonresourcegroups_effect_5 = "Disabled"
requirespecifiedtagonresourcegroups_effect_6 = "Disabled"
appendspecifiedtagfromresourcegroup_TAGNAME_1 = "Environment"
appendspecifiedtagfromresourcegroup_TAGNAME_2 = "Service"
appendspecifiedtagfromresourcegroup_TAGNAME_3 = "Owner"
appendspecifiedtagfromresourcegroup_TAGNAME_4 = "OwnerApp"
appendspecifiedtagfromresourcegroup_TAGNAME_5 = "Notes"
appendspecifiedtagfromresourcegroup_effect_1 = "Append"
appendspecifiedtagfromresourcegroup_effect_2 = "Append"
appendspecifiedtagfromresourcegroup_effect_3 = "Append"
appendspecifiedtagfromresourcegroup_effect_4 = "Append"
appendspecifiedtagfromresourcegroup_effect_5 = "Append"

resourcelocations_LISTOFALLOWEDLOCATIONS_1 = "northeurope","westeurope","switzerlandnorth","switzerlandwest"
resourcegrouplocations_LISTOFALLOWEDLOCATIONS_1 = "northeurope","westeurope","switzerlandnorth","switzerlandwest"
allowedvirtualmachineskus = "Standard_B1ms","Standard_B2s","Standard_B2ms","Standard_D2s_v3","Standard_D4s_v3","Standard_E2s_v3"
allowedvirtualmachines_effect = "Deny"
allowedstorageaccountskus = "Standard_LRS","Standard_RAGRS","Standard_GRS","Standard_ZRS"
allowedstorageaccountskus_effect = "Deny"
classicresources_effect = "Deny"
resourcelocations_effect = "Deny"
resourcegrouplocations_effect = "Deny"
networkinterfacesshouldnothavepublicipaddresses_effect = "Deny"
}
