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
    echo "Failed to get JWT token: ${error_message}"
    exit 1
else
    echo "Creating Users"
fi 



# Get access_token with jq
access_token=$(echo $login_result | jq -r '.access_token')


while read line; do

user=( $line )
username=${user[0]}
firstName=${user[1]}
lastName=${user[2]}
email=${user[3]}
password=${user[4]}
roleList=${user[5]}


#########
#Create user
#########
#Create a test user
echo "Creating user ${username} with email ${email}"
client_result=$(curl --silent --show-error \
-X POST \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
--data-raw "{\"firstName\": \"${firstName}\", \"lastName\": \"${lastName}\", \"email\": \"${email}\", \"enabled\": \"true\", \"username\": \"${username}\", \"emailVerified\": true}" \
"${KEYCLOAK_URL}/auth/admin/realms/${REALM}/users") 

user=$(curl --silent --show-error -X GET \
"${KEYCLOAK_URL}/auth/admin/realms/${REALM}/users?email=${email}" \
-H "Authorization: Bearer ${access_token}" \
-H 'Accept: application/json' \
-H 'cache-control: no-cache'
)

user_sub=$(echo "${user}" | jq '[.[]|select(.id)][0]' | jq -r '.id')

# Set password for user
client_result=$(curl --silent --show-error \
-X PUT \
-H "Authorization: Bearer ${access_token}" \
-H "Content-Type: application/json" \
-H 'Accept: application/json' \
--data-raw "{\"type\": \"password\", \"temporary\": false, \"value\": \"${password}\"}" \
"${KEYCLOAK_URL}/auth/admin/realms/${REALM}/users/${user_sub}/reset-password")


splitRoles=$(echo $roleList | tr ";" "\n")

for roleName in $splitRoles
do

roles=$(curl --silent --show-error -X GET "${KEYCLOAK_URL}/auth/admin/realms/task-repository-testing/roles/$roleName" \
 -H "Content-Type: application/json" \
 -H "Accept: application/json" \
 -H "Authorization: Bearer ${access_token}")


 roleId=$(echo $roles | jq -r '.id')

 
#Find user and get user id
 user=$(curl --silent --show-error -X GET "${KEYCLOAK_URL}/auth/admin/realms/task-repository-testing/users?email=${email}" \
 -H "Content-Type: application/json" \
 -H "Accept: application/json" \
 -H "Authorization: Bearer ${access_token}")

userId=$(echo $user | jq -r --slurp '.[0][0].id')

# Map realm role to user
 roles=$(curl --silent --show-error -X POST "${KEYCLOAK_URL}/auth/admin/realms/task-repository-testing/users/${userId}/role-mappings/realm" \
 -H "Content-Type: application/json" \
 -H "Accept: application/json" \
 -H "Authorization: Bearer ${access_token}" \
 -d "[{\"id\":\"${roleId}\",\"name\":\"${roleName}\"}]")

done #Roles Loop
done < /workspaces/application-api/scripts/test_users.txt #User Loop