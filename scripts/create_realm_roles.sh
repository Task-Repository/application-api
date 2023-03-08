#!/bin/bash

# Variables
REALM="task-repository-testing" 
CLIENT_ID="admin-cli"
KEYCLOAK_URL="http://localhost:8085"


# Obtain access token
login_result=$(curl --silent --show-error -X POST ${KEYCLOAK_URL}/auth/realms/master/protocol/openid-connect/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=admin" \
  -d "password=password" \
  -d "client_id=$CLIENT_ID" \
  -d "grant_type=password")

error_message=$(echo $client_result | jq -r '.errorMessage')

# if error_meesage is not null, then echo "failed to create client"
if [[ ! -z $error_meesage ]]; then
    echo "Failed to log into keycloak"
    exit 1
else
    echo "logged into keycloak"
fi 



# Get access_token with jq
access_token=$(echo $login_result | jq -r '.access_token')

while read role; do
curl --silent --show-error -X POST "${KEYCLOAK_URL}/auth/admin/realms/task-repository-testing/roles" \
 -H "Content-Type: application/json" \
 -H "Authorization: Bearer ${access_token}" \
 -d "{\"name\": \"$role\"}"
 echo "Added role ${role}"
 done < /workspaces/application-api/scripts/realm_roles.txt

