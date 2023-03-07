#!/bin/bash

# Variables
REALM="task-repository-testing" 
CLIENT_ID="frontend"
KEYCLOAK_URL="http://localhost:8085"

echo "usernam is ${1}"
echo "password is ${2}"
echo "client is ${CLIENT}"

# Obtain access token
login_result=$(curl -v --show-error -X POST ${KEYCLOAK_URL}/auth/realms/${REALM}/protocol/openid-connect/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=$1" \
  -d "password=$2" \
  -d "client_id=$CLIENT_ID" \
  -d "grant_type=password")

# Get access_token with jq
access_token=$(echo $login_result | jq -r '.access_token')

echo $access_token