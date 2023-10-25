# Create a Service Principal for the API Management integration
# Az login with an Azure AD administrator
az login --allow-no-subscriptions --tenant <YOUR_TENANT_ID>
# Create a service principal
SP=$(az ad sp create-for-rbac --name "apim-integration" --skip-assignment)
# Get the client id
CLIENT_ID=$(echo $SP | jq -r .appId)
# Get the client secret
CLIENT_SECRET=$(echo $SP | jq -r .password)
# Get the tenant id
TENANT_ID=$(echo $SP | jq -r .tenant)

# Assign API permissions for APIM
# Add Microsoft Graph Permissions
# https://docs.microsoft.com/es-es/graph/permissions-reference#retrieving-permission-ids
USER_READ_ALL_APP_PERMISSION=$(az ad sp list --query "[?appDisplayName=='Microsoft Graph'].{permissions:appRoles}[0].permissions[?value=='User.Read.All'].id" --all | jq -r '.[]')
GROUP_READ_ALL_APP_PERMISSION=$(az ad sp list --query "[?appDisplayName=='Microsoft Graph'].{permissions:appRoles}[0].permissions[?value=='Group.Read.All'].id" --all | jq -r '.[]')

# Assign the permission to the service principal
az ad app permission add --id $CLIENT_ID \
--api 00000003-0000-0000-c000-000000000000 \
--api-permissions $USER_READ_ALL_APP_PERMISSION=Role  $GROUP_READ_ALL_APP_PERMISSION=Role

# Grant permissions to the service principal
az ad app permission admin-consent --id $CLIENT_ID
# check the permissions
az ad app permission list --id $CLIENT_ID

terraform init -upgrade

terraform plan \
-var "aad_client_id=$CLIENT_ID" \
-var "aad_client_secret=$CLIENT_SECRET" \
-var "aad_tenant_id=$TENANT_ID" \
-out=tfplan

terraform apply \
-var "aad_client_id=$CLIENT_ID" \
-var "aad_client_secret=$CLIENT_SECRET" \
-var "aad_tenant_id=$TENANT_ID" \
-auto-approve \
tfplan

# Get the resource group name from terraform state
RESOURCE_GROUP_NAME=$(terraform output -raw service_name | sed 's/-//g')
STORAGE_ACCOUNT_NAME=$(terraform output -raw service_name | sed 's/-//g')
CONTAINER_NAME="tfstate"
LOCATION=$(terraform output -raw location)

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage account
az storage account create \
--resource-group $RESOURCE_GROUP_NAME \
--name $STORAGE_ACCOUNT_NAME \
--sku Standard_LRS \
--encryption-services blob

# Create blob container
az storage container create \
--name $CONTAINER_NAME \
--account-name $STORAGE_ACCOUNT_NAME

# Get storage account key
STORAGE_ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv)

# https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli
# Migrate the existing local state to the remote backend
terraform init \
-backend-config="storage_account_name=${STORAGE_ACCOUNT_NAME}" \
-backend-config="container_name=${CONTAINER_NAME}" \
-backend-config="access_key=${STORAGE_ACCOUNT_KEY}"

# Put this variables in .devcontainer/devcontainer.env
cat <<EOF > .devcontainer/devcontainer.env
STORAGE_ACCOUNT_NAME=$STORAGE_ACCOUNT_NAME
CONTAINER_NAME=$CONTAINER_NAME
STORAGE_ACCOUNT_KEY=$STORAGE_ACCOUNT_KEY
EOF

# If you can use Dev Container export the variables to the terminal
eval $(cat .devcontainer/devcontainer.env)

# Check the state
terraform state list

# Create variables file for the service principal
cat <<EOF > terraform.tfvars
aad_client_id = "$CLIENT_ID"
aad_client_secret = "$CLIENT_SECRET"
aad_tenant_id = "$TENANT_ID"
EOF

# Create the plan
terraform plan -out=tfplan

# Apply the plan
terraform apply -auto-approve

set -o allexport; source .env; set +o allexport
terraform init