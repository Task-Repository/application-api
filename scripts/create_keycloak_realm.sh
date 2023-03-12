#!/bin/bash

#   
# Create Keycloak Realm
#
apt update -y
apt install -y jq

echo "Setting up keycloak"

# Variables
NEW_REALM="task-repository-testing" # You should also change this in the realm.json file
NEW_CLIENT="api" # You should also change this in the client.json file
USERNAME="admin" 
PASSWORD="password"
REALM_FILE="realm.json"
API_CLIENT_FILE="api_client.json"
FRONTEND_CLIENT_FILE="frontend_client.json"
KEYCLOAK_URL="http://localhost:8085"



# Wait for Keycloak to start
echo "Waiting for keycloak to start"
until $(curl --output /dev/null --silent --head --fail ${KEYCLOAK_URL}/auth/realms/master); do
    printf '.'
    sleep 5
done
echo
echo "Keycloak started"
sleep 1
# Obtain access token
echo $USERNAME
echo $PASSWORD
login_result=$(curl -v --show-error -X POST ${KEYCLOAK_URL}/auth/realms/master/protocol/openid-connect/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Accept: application/json" \
  -d "username=$USERNAME" \
  -d "password=$PASSWORD" \
  -d 'grant_type=password' \
  -d 'client_id=admin-cli')

echo $login_result
# Get access_token with jq
access_token=$(echo $login_result | jq -r '.access_token')





##########
# Create realm
##########

# Create a realm using curl and the access_token as a Bearer token
realm_result=$(curl --silent --show-error \
-X POST \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-d @"${REALM_FILE}" \
"${KEYCLOAK_URL}/auth/admin/realms")

if [[ $realm_result == *"Conflict detected"* ]]; then
    echo "Realm already exists, exiting"
    exit 0
fi

echo "Created keycloak realm ${NEW_REALM}"



##########
# Create api client
##########

# Create a client using curl and the access_token as a Bearer token
client_result=$(curl --silent --show-error \
-X POST \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-d @"${API_CLIENT_FILE}" \
"${KEYCLOAK_URL}/auth/admin/realms/${NEW_REALM}/clients")


error_message=$(echo $client_result | jq -r '.errorMessage')

# if error_meesage is not null, then echo "failed to create client"
if [[ ! -z $error_meesage ]]; then
    echo "Failed to create client: ${error_message}"
    exit 1
else
    echo "Created client ${NEW_CLIENT}"
fi 


##########
# Create frontend client
##########

# Create a client using curl and the access_token as a Bearer token
client_result=$(curl --silent --show-error \
-X POST \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-d @"${FRONTEND_CLIENT_FILE}" \
"${KEYCLOAK_URL}/auth/admin/realms/${NEW_REALM}/clients")


error_message=$(echo $client_result | jq -r '.errorMessage')

# if error_meesage is not null, then echo "failed to create client"
if [[ ! -z $error_meesage ]]; then
    echo "Failed to create client: ${error_message}"
    exit 1
else
    echo "Created client ${NEW_CLIENT}"
fi 

/bin/bash /workspaces/application-api/scripts/create_realm_roles.sh
/bin/bash /workspaces/application-api/scripts/create_keycloak_users.sh




