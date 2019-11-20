﻿#location for MSI
$location = "westeurope"

#Define Locking Mode
$lockMode = 'None'  # AllResourcesDoNotDelete | AllResourcesDoNotDelete | AllResourcesReadOnly | None

#parameters for Resource Group
$resourceGroupParams = @{
    name = "d-rgr-eleuGovernance"
}

#parameters for artifacts
$params = @{
automationAccount_accountName='p-aut-eleu2019'
automationAccount_accountType= 'Basic'
keyVault_vaultName = 'p-kva-eleu2019-01'
keyVault_sku ='Premium'
keyVault_tenantId= '51ac169a-f7b2-4f60-9736-0211c8e18a87'
keyVault_userId = 'cfc359db-3d29-460f-b516-f7d00234631e'
logAnalyticsWorkspace_logAnalyticsWorkspaceName = 'p-ala-eleu2019-87538'
logAnalyticsWorkspace_automationAccountName = 'p-aut-eleu2019'
SecurityCenter_workspaceName = 'p-ala-eleu2019-87538'
SecurityCenter_workspaceResourceGroup = 'd-rgr-eleuGovernance'
SecurityCenter_subscriptionId = '1ab8c496-2991-43e2-9d80-0bfe0eb0d872'
storageAccountforCloudShell_storageAccountName = 'pstoe19shellhsg01'
storageAccountforCloudShell_accountType = 'Standard_LRS'
storageAccountforDiagnosticLogs_storageAccountName = 'pstoe19loghsg01'
storageAccountforDiagnosticLogs_accountType = 'Standard_LRS'
storageAccountforArtifacts_storageAccountName = 'pstoe19armhsg01'
StorageAccountforArtifacts_containerName = 'armtemplates'
storageAccountforArtifacts_accountType  = 'Standard_LRS'
activitylogs_subscriptionId = '1ab8c496-2991-43e2-9d80-0bfe0eb0d872'
activitylogs_workspaceName = 'p-ala-eleu2019-87538'

#base governance Policy Initiative Parameters
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
appendspecifiedtagfromresourcegroup_TAGNAME_1 = "Environment"
appendspecifiedtagfromresourcegroup_TAGNAME_2 = "Service"
appendspecifiedtagfromresourcegroup_TAGNAME_3 = "Owner"
appendspecifiedtagfromresourcegroup_TAGNAME_4 = "OwnerApp"
appendspecifiedtagfromresourcegroup_TAGNAME_5 = "Notes"
appendspecifiedtagfromresourcegroup_effect_1 = "Append"
appendspecifiedtagfromresourcegroup_effect_2 = "Append"
appendspecifiedtagfromresourcegroup_effect_3 = "Append"
appendspecifiedtagfromresourcegroup_effect_4 = "Append"
appendspecifiedtagfromresourcegroup_effect_5 = "Disabled"

resourcelocations_LISTOFALLOWEDLOCATIONS_1 = "northeurope","westeurope","switzerlandnorth","switzerlandwest"
resourcegrouplocations_LISTOFALLOWEDLOCATIONS_1 = "northeurope","westeurope","switzerlandnorth","switzerlandwest"
allowedvirtualmachineskus = "Standard_B1ms","Standard_B2s","Standard_B2ms","Standard_DS1_v2","Standard_D2s_v3","Standard_Ds3_v2","Standard_D4s_v3","Standard_E2s_v3"
allowedvirtualmachines_effect = "Deny"
allowedstorageaccountskus = "Standard_LRS","Standard_RAGRS","Standard_GRS","Standard_ZRS"
allowedstorageaccountskus_effect = "Deny"
classicresources_effect = "Deny"
resourcelocations_effect = "Deny"
resourcegrouplocations_effect = "Deny"
networkinterfacesshouldnothavepublicipaddresses_effect = "Deny"

#SecurityCenter Policy Initiative Parameters
EnableMonitoringinAzureSecurityCenter_vmssSystemUpdatesMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_vmssEndpointProtectionMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_vmssOsVulnerabilitiesMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_systemUpdatesMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_systemConfigurationsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_endpointProtectionMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_diskEncryptionMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_networkSecurityGroupsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_networkSecurityGroupsOnSubnetsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_networkSecurityGroupsOnVirtualMachinesMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_webApplicationFirewallMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_nextGenerationFirewallMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_vulnerabilityAssesmentMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_serverVulnerabilityAssessmentEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_storageEncryptionMonitoringEffect="Audit"
EnableMonitoringinAzureSecurityCenter_jitNetworkAccessMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_adaptiveApplicationControlsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_sqlAuditingMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_sqlEncryptionMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_sqlDbEncryptionMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_sqlServerAuditingMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_sqlServerAuditingActionsAndGroupsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_SqlServerAuditingRetentionDaysMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInAppServiceMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInSelectiveAppServicesMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_encryptionOfAutomationAccountMonitoringEffect="Audit"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInBatchAccountMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInBatchAccountRetentionDays="365"
EnableMonitoringinAzureSecurityCenter_metricAlertsInBatchAccountMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_classicComputeVMsMonitoringEffect="Audit"
EnableMonitoringinAzureSecurityCenter_classicStorageAccountsMonitoringEffect="Audit"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInDataLakeAnalyticsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInDataLakeAnalyticsRetentionDays="365"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInDataLakeStoreMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInDataLakeStoreRetentionDays="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInEventHubMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInEventHubRetentionDays="365"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInKeyVaultMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInKeyVaultRetentionDays="365"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInLogicAppsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInLogicAppsRetentionDays="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInRedisCacheMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInSearchServiceMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInSearchServiceRetentionDays="365"
EnableMonitoringinAzureSecurityCenter_aadAuthenticationInServiceFabricMonitoringEffect="Audit"
EnableMonitoringinAzureSecurityCenter_clusterProtectionLevelInServiceFabricMonitoringEffect="Audit"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInServiceBusMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInServiceBusRetentionDays="365"
EnableMonitoringinAzureSecurityCenter_namespaceAuthorizationRulesInServiceBusMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_aadAuthenticationInSqlServerMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_secureTransferToStorageAccountMonitoringEffect="Audit"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInStreamAnalyticsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInStreamAnalyticsRetentionDays="365"
EnableMonitoringinAzureSecurityCenter_useRbacRulesMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_disableUnrestrictedNetworkToStorageAccountMonitoringEffect="Audit"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInServiceFabricMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_accessRulesInEventHubNamespaceMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_accessRulesInEventHubMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_sqlDbVulnerabilityAssesmentMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_sqlDbDataClassificationMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_identityDesignateLessThanOwnersMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_identityDesignateMoreThanOneOwnerMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_identityEnableMFAForOwnerPermissionsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_identityEnableMFAForWritePermissionsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_identityEnableMFAForReadPermissionsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_identityRemoveDeprecatedAccountWithOwnerPermissionsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_identityRemoveDeprecatedAccountMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_identityRemoveExternalAccountWithOwnerPermissionsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_identityRemoveExternalAccountWithWritePermissionsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_identityRemoveExternalAccountWithReadPermissionsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_apiAppConfigureIPRestrictionsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_functionAppConfigureIPRestrictionsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_webAppConfigureIPRestrictionsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_apiAppDisableRemoteDebuggingMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_functionAppDisableRemoteDebuggingMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_webAppDisableRemoteDebuggingMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_apiAppDisableWebSocketsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_functionAppDisableWebSocketsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_webAppDisableWebSocketsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_apiAppEnforceHttpsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_functionAppEnforceHttpsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_webAppEnforceHttpsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_apiAppEnforceHttpsMonitoringEffectV2="Audit"
EnableMonitoringinAzureSecurityCenter_functionAppEnforceHttpsMonitoringEffectV2="Audit"
EnableMonitoringinAzureSecurityCenter_webAppEnforceHttpsMonitoringEffectV2="Audit"
EnableMonitoringinAzureSecurityCenter_apiAppRestrictCORSAccessMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_functionAppRestrictCORSAccessMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_webAppRestrictCORSAccessMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_apiAppUsedCustomDomainsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_functionAppUsedCustomDomainsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_webAppUsedCustomDomainsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_apiAppUsedLatestDotNetMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_webAppUsedLatestDotNetMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_apiAppUsedLatestJavaMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_webAppUsedLatestJavaMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_webAppUsedLatestNodeJsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_apiAppUsedLatestPHPMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_webAppUsedLatestPHPMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_apiAppUsedLatestPythonMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_webAppUsedLatestPythonMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_vnetEnableDDoSProtectionMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInIoTHubMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_diagnosticsLogsInIoTHubRetentionDays="365"
EnableMonitoringinAzureSecurityCenter_sqlServerAdvancedDataSecurityMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_sqlManagedInstanceAdvancedDataSecurityMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_sqlServerAdvancedDataSecurityEmailsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_sqlManagedInstanceAdvancedDataSecurityEmailsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_sqlServerAdvancedDataSecurityEmailAdminsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_sqlManagedInstanceAdvancedDataSecurityEmailAdminsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_kubernetesServiceRbacEnabledMonitoringEffect="Audit"
EnableMonitoringinAzureSecurityCenter_kubernetesServicePspEnabledMonitoringEffect="Audit"
EnableMonitoringinAzureSecurityCenter_kubernetesServiceAuthorizedIPRangesEnabledMonitoringEffect="Audit"
EnableMonitoringinAzureSecurityCenter_kubernetesServiceVersionUpToDateMonitoringEffect="Audit"
EnableMonitoringinAzureSecurityCenter_vulnerabilityAssessmentOnManagedInstanceMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_vulnerabilityAssessmentOnServerMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_threatDetectionTypesOnManagedInstanceMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_threatDetectionTypesOnServerMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_adaptiveNetworkHardeningsMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_restrictAccessToManagementPortsMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_restrictAccessToAppServicesMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_disableIPForwardingMonitoringEffect="AuditIfNotExists"
EnableMonitoringinAzureSecurityCenter_ensureServerTDEIsEncryptedWithYourOwnKeyMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_ensureManagedInstanceTDEIsEncryptedWithYourOwnKeyMonitoringEffect="Disabled"
EnableMonitoringinAzureSecurityCenter_containerBenchmarkMonitoringEffect="AuditIfNotExists"

}

#build the resource group hash array
$rgArray = @{ ResourceGroup = $resourceGroupParams }