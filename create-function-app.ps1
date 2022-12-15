$startDate = Get-Date
Write-Output "$startDate - Process started"

$guid = New-Guid

$guid -match '^[^-]+'

$sufix = $Matches.0

$location = "westeurope"
$resourceGroup = "demo-rg"
$storageAccount = "demoaccount" + $sufix
$functionApp = "demo-fa-" + $sufix
$skuStorage = "Standard_LRS"
$functionsVersion = "4"

# Create a resource group
Write-Output "Creating $resourceGroup in "$location"..."
az group create --name $resourceGroup --location "$location"

# Create an Azure storage account in the resource group.
Write-Output "Creating $storageAccount"
az storage account create --name $storageAccount --location "$location" --resource-group $resourceGroup --sku $skuStorage

# Create a serverless function app in the resource group.
Write-Output "Creating $functionApp"
az functionapp create --name $functionApp --storage-account $storageAccount --consumption-plan-location "$location" --resource-group $resourceGroup --functions-version $functionsVersion

Write-Output "Successfully created"

$endDate = Get-Date
Write-Output "$endDate - Process completed"