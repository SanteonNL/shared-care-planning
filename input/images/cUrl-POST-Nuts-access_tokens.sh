## -- UC: access the hospital FHIR API from CPS --
# The docker compose and ngrok need to run to make this work.
# The internal URL of the hospital NUTS node
export CPC1_INTERNAL_API="http://localhost:8081"
# The internal URL of the care plan service (CPS) NUTS node
export CPS_INTERNAL_API="http://localhost:8181"
# The internal URL of the care plan service (CPC2) is the SAME NUTS node as CPS
export CPC2_INTERNAL_API=$CPS_INTERNAL_API

export CPC1_SUBJECT="hospital_x"
export CPC2_SUBJECT="msc"
export CPS_SUBJECT="care_plan_service"


## -- UC: access m CPS FHIR API from the hospital --
# Get the CPS DID
CPS_DID_JSON=$(curl -s --location "${CPS_INTERNAL_API}/internal/vdr/v2/subject/${CPS_SUBJECT}" \
               --header 'Accept: application/json')
CPS_DID=$(echo "$CPS_DID_JSON" | jq -r .[0])
echo $CPS_DID

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

## -- UC: access the hospital FHIR API from CPS --

## Get the CPC1 DID
CPC1_DID_JSON=$(curl -s --location "${CPC1_INTERNAL_API}/internal/vdr/v2/subject/${CPC1_SUBJECT}" \
               --header 'Accept: application/json')
CPC1_DID=$(echo "$CPC1_DID_JSON" | jq -r .[0])
echo $CPC1_DID

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

# Get the CPC2 DID
CPC2_DID_JSON=$(curl -s --location "${CPC2_INTERNAL_API}/internal/vdr/v2/subject/${CPC2_SUBJECT}" \
               --header 'Accept: application/json')
CPC2_DID=$(echo "$CPC2_DID_JSON" | jq -r .[0])
echo $CPC2_DID

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
