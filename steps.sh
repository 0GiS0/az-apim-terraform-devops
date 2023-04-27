terraform init \
-backend-config="storage_account_name=${STORAGE_ACCOUNT_NAME}" \
-backend-config="container_name=${STORAGE_ACCOUNT_CONTAINER}" \
-backend-config="access_key=${STORAGE_ACCOUNT_KEY}"

terraform plan \
-backend-config="storage_account_name=${STORAGE_ACCOUNT_NAME}" \
-backend-config="container_name=${STORAGE_ACCOUNT_CONTAINER}" \
-var "aad_client_id=$CLIENT_ID" \
-var "aad_client_secret=$CLIENT_SECRET" \
-var "aad_tenant_id=$TENANT_ID"

terraform apply \
-backend-config="storage_account_name=${STORAGE_ACCOUNT_NAME}" \
-backend-config="container_name=${STORAGE_ACCOUNT_CONTAINER}" \
-var "aad_client_id=$CLIENT_ID" \
-var "aad_client_secret=$CLIENT_SECRET" \
-var "aad_tenant_id=$TENANT_ID"