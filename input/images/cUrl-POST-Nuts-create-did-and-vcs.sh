# This file assumes a running docker-compose setup as defined in docker-compose-nuts-nodes.sh
# Please note that

# The docker compose and ngrok need to run to make this work.
# The internal URL of the hospital NUTS node
export CPC1_INTERNAL_API="http://localhost:8081"
# The internal URL of the care plan service (CPS) NUTS node
export CPS_INTERNAL_API="http://localhost:8181"
# The internal URL of the care plan service (CPC2) is the SAME NUTS node as CPS
export CPC2_INTERNAL_API=$CPS_INTERNAL_API

# The values are used as subject in the DID creation of both the hospital and the care plan service.
export CPC1_SUBJECT="hospital_x"
export CPC2_SUBJECT="msc"
export CPS_SUBJECT="care_plan_service"
# The values fro the hospital.
export URA="124453423"
export CITY="Amsterdam"

# This will create a new DID on the hospital side.
echo "Create $CPC1_SUBJECT DID"
CPC1_DID_DOC=$(curl -s --location "${CPC1_INTERNAL_API}/internal/vdr/v2/subject" \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data "{
  \"subject\": \"${CPC1_SUBJECT}\"
}")
echo "$CPC1_DID_DOC"
CPC1_DID=$(echo "$CPC1_DID_DOC" | jq -r .documents[0].id)
echo "$CPC1_DID"

# This will create a new DID on the CPS side.
echo "Create $CPS_SUBJECT DID"
CPS_DID_DOC=$(curl -s --location "${CPS_INTERNAL_API}/internal/vdr/v2/subject" \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data "{
  \"subject\": \"$CPS_SUBJECT\"
}")
echo "$CPS_DID_DOC"
CPS_DID=$(echo "$CPS_DID_DOC" | jq -r .documents[0].id)
echo "$CPS_DID"

# This will create a new DID on the CPS side.
echo "Create $CPC2_SUBJECT DID"
CPC2_DID_DOC=$(curl -s --location "${CPS_INTERNAL_API}/internal/vdr/v2/subject" \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data "{
  \"subject\": \"$CPC2_SUBJECT\"
}")
echo "$CPC2_DID_DOC"
CPC2_DID=$(echo "$CPC2_DID_DOC" | jq -r .documents[0].id)
echo "$CPC2_DID"

# This will create a new VC on the CPS NUTS node, issued to the hospital.
CPC1_VC_DOC=$(curl -s --location "${CPS_INTERNAL_API}/internal/vcr/v2/issuer/vc" \
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
      \"id\": \"${CPC1_DID}\",
      \"organization\": {
        \"ura\": \"${URA}\",
        \"name\": \"${CPC1_SUBJECT}\",
        \"city\": \"${CITY}\"
      }
    },
    \"withStatusList2021Revocation\": false
  }")

echo "$CPC1_VC_DOC"

# This will create a post the VC on the hospital NUTS node.
curl -s --location "$CPC1_INTERNAL_API/internal/vcr/v2/holder/$CPC1_DID/vc" \
  --header 'Content-Type: application/json' \
  --data "$CPC1_VC_DOC"

# Superfluous call to list the VSs.
curl -s --location "$CPC1_INTERNAL_API/internal/vcr/v2/holder/$CPC1_DID/vc" \
--header 'Accept: application/json'

# This will create a new VC on the CPS NUTS node, issued to the hospital.
CPS_VC_DOC=$(curl -s --location "${CPS_INTERNAL_API}/internal/vcr/v2/issuer/vc" \
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
curl -s --location "$CPS_INTERNAL_API/internal/vcr/v2/holder/$CPS_DID/vc" \
  --header 'Content-Type: application/json' \
  --data "$CPS_VC_DOC"

# Superfluous call to list the VSs.
curl -s --location "$CPS_INTERNAL_API/internal/vcr/v2/holder/$CPS_DID/vc" \
--header 'Accept: application/json'

## -- UC: access the CPS FHIR API from the hospital to CPS --

# The next item needs the public host name of the CPS NUTS node, this is done by extracting it from the DID.
# In a more realistic situation this would be either known or available in a DID document.
CPS_DID_PARTS=(${CPS_DID//:/ })
CPS_HOST="${CPS_DID_PARTS[2]}"
echo "$CPS_HOST"

# This call gets a access token on the hospital's NUTS node to access data on the CPS FHIR environment.
CPS_ACCESS_TOKEN_JSON=$(curl -s --location "$CPC1_INTERNAL_API/internal/auth/v2/$CPC1_SUBJECT/request-service-access-token" \
  --header 'Content-Type: application/json' \
  --data-raw "{
    \"authorization_server\": \"https://$CPS_HOST/oauth2/$CPS_SUBJECT\",
    \"scope\": \"careplanservice\"
  }")

# Get the access_token from the JSON
echo "$CPS_ACCESS_TOKEN_JSON"
CPS_ACCESS_TOKEN=$(echo "$CPS_ACCESS_TOKEN_JSON" | jq -r .access_token)
echo "$CPS_ACCESS_TOKEN"

# The verification step: the CPS NUTS node will validate the token.
curl -s --location "$CPS_INTERNAL_API/internal/auth/v2/accesstoken/introspect_extended" \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --data "token=$CPS_ACCESS_TOKEN"

## -- UC: access the hospital FHIR API from CPS --

# The next item needs the public host name of the CPS NUTS node, this is done by extracting it from the DID.
# In a more realistic situation this would be either known or available in a DID document.
CPC1_DID_PARTS=(${CPC1_DID//:/ })
CPC1_HOST="${CPC1_DID_PARTS[2]}"
echo "$CPC1_HOST"

# This call gets a access token on the CPS's NUTS node to access data on the Hospital FHIR environment.
CPC1_ACCESS_TOKEN_JSON=$(curl -s --location "$CPS_INTERNAL_API/internal/auth/v2/$CPS_SUBJECT/request-service-access-token" \
  --header 'Content-Type: application/json' \
  --data-raw "{
    \"authorization_server\": \"https://$CPC1_HOST/oauth2/$CPC1_SUBJECT\",
    \"scope\": \"homemonitoring\"
  }")
# Get the access_token from the JSON
echo "$CPC1_ACCESS_TOKEN_JSON"
CPC1_ACCESS_TOKEN=$(echo "$CPC1_ACCESS_TOKEN_JSON" | jq -r .access_token)
echo "$CPC1_ACCESS_TOKEN"


## -- UC: access the MSC FHIR API from CPS --

# The next item needs the public host name of the CPS NUTS node, this is done by extracting it from the DID.
# In a more realistic situation this would be either known or available in a DID document.
CPC2_DID_PARTS=(${CPC2_DID//:/ })
CPC2_HOST="${CPC2_DID_PARTS[2]}"
echo "$CPC2_HOST"
# This call gets a access token on the CPS's NUTS node to access data on the MSC FHIR environment.
CPC2_ACCESS_TOKEN_JSON=$(curl -s --location "$CPS_INTERNAL_API/internal/auth/v2/$CPS_SUBJECT/request-service-access-token" \
  --header 'Content-Type: application/json' \
  --data-raw "{
    \"authorization_server\": \"https://$CPC2_HOST/oauth2/$CPC2_SUBJECT\",
    \"scope\": \"homemonitoring\"
  }")
# Get the access_token from the JSON
echo "$CPC2_ACCESS_TOKEN_JSON"
CPC2_ACCESS_TOKEN=$(echo "$CPC2_ACCESS_TOKEN_JSON" | jq -r .access_token)
echo "$CPC2_ACCESS_TOKEN"

echo For getting NUTS access_tokens, the following variables need to be set:
echo export CPS_DID="$CPS_DID"
echo export CPC1_DID="$CPC1_DID"
echo export CPC2_DID="$CPC2_DID"
echo export CPS_SUBJECT="$CPS_SUBJECT"
echo export CPC1_SUBJECT="$CPC1_SUBJECT"
echo export CPC2_SUBJECT="$CPC2_SUBJECT"
echo export CPC1_INTERNAL_API="$CPC1_INTERNAL_API"
echo export CPS_INTERNAL_API="$CPS_INTERNAL_API"
