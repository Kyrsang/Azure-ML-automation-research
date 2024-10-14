# # Service Principal 생성 
# az ad sp create-for-rbac --name "azure-ml-aks-public" `
#     --role contributor `
#      --scopes /subscriptions/{SUBSCRIPTION_ID} `
#      --sdk-auth

# {
#   "clientId": "",
#   "clientSecret": "",
#   "subscriptionId": "",
#   "tenantId": "",
#   "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
#   "resourceManagerEndpointUrl": "https://management.azure.com/",
#   "activeDirectoryGraphResourceId": "https://graph.windows.net/",
#   "sqlManagementEndpointUrl": "https://management.core.windows.net:8443/",
#   "galleryEndpointUrl": "https://gallery.azure.com/",
#   "managementEndpointUrl": "https://management.core.windows.net/"
# }


# Credential 저장
$clientId = "{SERVICE_PRINCIPAL_CLIENT_ID}"
$clientSecret = "{SERVICE_PRINCIPAL_CLIENT_SECRET}"
$tenantId = "{TENANT_ID}"
$subscriptionId = "{SUBSCRIPTION_ID}"

az login --service-principal --username $clientId --password $clientSecret --tenant $tenantId

