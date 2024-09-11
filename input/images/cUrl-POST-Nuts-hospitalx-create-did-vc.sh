# This file assumes a running docker-compose setup as defined in docker-compose-nuts-nodes.sh
# Please note that

# The docker compose and ngrok need to run to make this work.
# The internal URL of the hospital NUTS node
export HOSPITAL_INTERNAL_API="http://localhost:8081"
# The internal URL of the care plan service (CPS) NUTS node
export CPS_INTERNAL_API="http://localhost:8181"

# The values are used as subject in the DID creation of both the hospital and the care plan service.
export HOSPITAL_SUBJECT="hospital_x"
export CPS_SUBJECT="care_plan_service"
# The values fro the hospital.
export URA="124453423"
export CITY="Amsterdam"

# This will create a new DID on the hospital side.
echo "Create $HOSPITAL_SUBJECT DID"
HOSPITAL_DID_DOC=$(curl --location "${HOSPITAL_INTERNAL_API}/internal/vdr/v2/subject" \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data "{
  \"subject\": \"${HOSPITAL_SUBJECT}\"
}")
echo "$HOSPITAL_DID_DOC"
HOSPITAL_DID=$(echo "$HOSPITAL_DID_DOC" | jq -r .documents[0].id)
echo "$HOSPITAL_DID"

# This will create a new DID on the CPS side.
echo "Create $CPS_SUBJECT DID"
CPS_DID_DOC=$(curl --location "${CPS_INTERNAL_API}/internal/vdr/v2/subject" \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data "{
  \"subject\": \"$CPS_SUBJECT\"
}")
echo "$CPS_DID_DOC"
CPS_DID=$(echo "$CPS_DID_DOC" | jq -r .documents[0].id)
echo "$CPS_DID"

# This will create a new VC on the CPS NUTS node, issued to the hospital.
HOSPITAL_VC_DOC=$(curl --location "${CPS_INTERNAL_API}/internal/vcr/v2/issuer/vc" \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data-raw "{
    \"@context\": [
      \"https://www.w3.org/2018/credentials/v1\",
      \"https://nuts.nl/credentials/2024\"
    ],
    \"type\": \"NutsUraCredential\",
    \"issuer\": \"${CPS_DID}\",
    \"credentialSubject\": {
      \"id\": \"${HOSPITAL_DID}\",
      \"organization\": {
        \"ura\": \"${URA}\",
        \"name\": \"${HOSPITAL_SUBJECT}\",
        \"city\": \"${CITY}\"
      }
    },
    \"withStatusList2021Revocation\": false
  }")

echo "$HOSPITAL_VC_DOC"

# This will create a post the VC on the hospital NUTS node.
curl --location "$HOSPITAL_INTERNAL_API/internal/vcr/v2/holder/$HOSPITAL_DID/vc" \
  --header 'Content-Type: application/json' \
  --data "$HOSPITAL_VC_DOC"

# Superfluous call to list the VSs.
curl --location "$HOSPITAL_INTERNAL_API/internal/vcr/v2/holder/$HOSPITAL_DID/vc" \
--header 'Accept: application/json'

# This will create a new VC on the CPS NUTS node, issued to the hospital.
CPS_VC_DOC=$(curl --location "${CPS_INTERNAL_API}/internal/vcr/v2/issuer/vc" \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data-raw "{
    \"@context\": [
      \"https://www.w3.org/2018/credentials/v1\",
      \"https://nuts.nl/credentials/2024\"
    ],
    \"type\": \"NutsUraCredential\",
    \"issuer\": \"${CPS_DID}\",
    \"credentialSubject\": {
      \"id\": \"${CPS_DID}\",
      \"organization\": {
        \"ura\": \"${URA}\",
        \"name\": \"${CPS_SUBJECT}\",
        \"city\": \"${CITY}\"
      }
    },
    \"withStatusList2021Revocation\": false
  }")

echo "$CPS_VC_DOC"

# This will create a post the VC on the CPS NUTS node.
curl --location "$CPS_INTERNAL_API/internal/vcr/v2/holder/$CPS_DID/vc" \
  --header 'Content-Type: application/json' \
  --data "$CPS_VC_DOC"

# Superfluous call to list the VSs.
curl --location "$CPS_INTERNAL_API/internal/vcr/v2/holder/$CPS_DID/vc" \
--header 'Accept: application/json'

## -- UC: access the CPS FHIR API from the hospital to CPS --

# The next item needs the public host name of the CPS NUTS node, this is done by extracting it from the DID.
# In a more realistic situation this would be either known or available in a DID document.
CPS_DID_PARTS=(${CPS_DID//:/ })
CPS_HOST="${CPS_DID_PARTS[2]}"
echo "$CPS_HOST"

# This call gets a access token on the hospital's NUTS node to access data on the CPS FHIR environment.
HOSPITAL_ACCESS_TOKEN_JSON=$(curl --location "$HOSPITAL_INTERNAL_API/internal/auth/v2/$HOSPITAL_SUBJECT/request-service-access-token" \
  --header 'Content-Type: application/json' \
  --data-raw "{
    \"authorization_server\": \"https://$CPS_HOST/oauth2/$CPS_SUBJECT\",
    \"scope\": \"careplanservice\"
  }")

# Get the access_token from the JSON
echo "$HOSPITAL_ACCESS_TOKEN_JSON"
HOSPITAL_ACCESS_TOKEN=$(echo "$HOSPITAL_ACCESS_TOKEN_JSON" | jq -r .access_token)
echo "$HOSPITAL_ACCESS_TOKEN"

# The verification step: the CPS NUTS node will validate the token.
curl --location "$CPS_INTERNAL_API/internal/auth/v2/accesstoken/introspect_extended" \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --data "token=$HOSPITAL_ACCESS_TOKEN"

## -- UC: access the hospital FHIR API from CPS --

# The next item needs the public host name of the CPS NUTS node, this is done by extracting it from the DID.
# In a more realistic situation this would be either known or available in a DID document.
HOSPITAL_DID_PARTS=(${HOSPITAL_DID//:/ })
HOSPITAL_HOST="${HOSPITAL_DID_PARTS[2]}"
echo "$HOSPITAL_HOST"

# This call gets a access token on the hospital's NUTS node to access data on the CPS FHIR environment.
CPS_ACCESS_TOKEN_JSON=$(curl --location "$CPS_INTERNAL_API/internal/auth/v2/$CPS_SUBJECT/request-service-access-token" \
  --header 'Content-Type: application/json' \
  --data-raw "{
    \"authorization_server\": \"https://$HOSPITAL_HOST/oauth2/$HOSPITAL_SUBJECT\",
    \"scope\": \"homemonitoring\"
  }")
# Get the access_token from the JSON
echo "$CPS_ACCESS_TOKEN_JSON"
CPS_ACCESS_TOKEN=$(echo "$CPS_ACCESS_TOKEN_JSON" | jq -r .access_token)
echo "$CPS_ACCESS_TOKEN"
