#!/bin/bash

# Variables
# REALM="master" 
# CLIENT_ID="admin-cli"
KEYCLOAK_URL="http://localhost:8085"

if [ -z "$3" ] 
then
  REALM="master"
else
  REALM=$3
fi

if [ -z "$4" ] 
then
  CLIENT_ID="admin-cli"
else
  CLIENT_ID=$4
fi




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