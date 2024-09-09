export NAME="hospital_x"
export URA="124453423"
export CITY="Amsterdam"
export HOSPITAL_INTERNAL_API="http://localhost:8081"
export CPS_INTERNAL_API="http://localhost:8181"



echo "Create $NAME DID"
HOSPITAL_DID_DOC=$(curl --location "${HOSPITAL_INTERNAL_API}/internal/vdr/v2/subject" \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data "{
  \"subject\": \"${NAME}\"
}")
echo "$HOSPITAL_DID_DOC"
HOSPITAL_DID=$(echo "$HOSPITAL_DID_DOC" | jq -r .documents[0].id)
echo "$HOSPITAL_DID"

echo "Create CPS DID"
CPS_DID_DOC=$(curl --location "${CPS_INTERNAL_API}/internal/vdr/v2/subject" \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--data "{
  \"subject\": \"CPS\"
}")
echo "$CPS_DID_DOC"
CPS_DID=$(echo "$CPS_DID_DOC" | jq -r .documents[0].id)
echo "$CPS_DID"

VC_DOC=$(curl --location "${CPS_INTERNAL_API}/internal/vcr/v2/issuer/vc" \
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
        \"name\": \"${NAME}\",
        \"city\": \"${CITY}\"
      }
    },
    \"withStatusList2021Revocation\": false
  }")

echo "$VC_DOC"


curl --location "$HOSPITAL_INTERNAL_API/internal/vcr/v2/holder/$HOSPITAL_DID/vc" \
  --header 'Content-Type: application/json' \
  --data "$VC_DOC"

curl --location "$HOSPITAL_INTERNAL_API/internal/vcr/v2/holder/did:web:d996-195-240-138-159.ngrok-free.app:iam:221ab978-ecea-48f8-b146-3450d8e6f386/vc" \
--header 'Accept: application/json'

curl --location "$HOSPITAL_INTERNAL_API/internal/auth/v2/$HOSPITAL_DID/request-service-access-token" \
  --header 'Content-Type: application/json' \
--data-raw "{
    \"verifier\": \"${CPS_DID}\",
    \"scope\": \"scp_cpc\"
  }"
