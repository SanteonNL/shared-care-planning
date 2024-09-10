#!/bin/bash

# Defining the environment variables for the curl statements
export CPS_BASE_URL="http://localhost:8080/fhir/"
export CPC1_BASE_URL="http://localhost:8080/fhir/"
export CPC2_BASE_URL="http://localhost:8080/fhir/"
export CPS_ACCESS_TOKEN="cps"
export CPC1_ACCESS_TOKEN="cpc1"
export CPC2_ACCESS_TOKEN="cpc2"

curlstatements=(
  "cUrl-POST-Bundle-hospitalx-bundle-01-to-cpc1-base-url.txt"
  "cUrl-POST-Bundle-msc-bundle-01-to-cpc2-base-url.txt"
  "cUrl-GET-CarePlan-from-cps-base-url.txt"
  "cUrl-POST-Bundle-cps-bundle-01-to-cps-base-url.txt"
  "cUrl-POST-Subscription-cps-sub-medicalservicecentre-to-cps-base-url.txt"
  "cUrl-POST-Subscription-cps-sub-hospitalx-to-cps-base-url.txt"
#   "cUrl-POST-Bundle-notification-msc-01-to-cps-base-url.txt"
  "cUrl-POST-CareTeam-cps-careteam-01-to-cps-base-url.txt"
  "cUrl-POST-CarePlan-cps-careplan-01-to-cps-base-url.txt"
#   "cUrl-POST-Bundle-notification-hospitalx-01-to-cps-base-url.txt"
  "cUrl-GET-cps-task-01-from-cps-base-url.txt"
  "cUrl-GET-cps-servicerequest-telemonitoring-from-cps-base-url.txt"
  "cUrl-GET-cps-heartfailure-from-cps-base-url.txt"
  "cUrl-POST-Bundle-cps-bundle-02-to-cps-base-url.txt"
#   "cUrl-POST-Bundle-notification-hospitalx-02-to-cps-base-url.txt"
  "cUrl-GET-cps-task-02-from-cps-base-url.txt"
  "cUrl-GET-cps-questionnaire-telemonitoring-enrollment-criteria-from-cps-base-url.txt"
  "cUrl-POST-Bundle-cps-bundle-03-to-cps-base-url.txt"
#   "cUrl-POST-Bundle-notification-msc-02-to-cps-base-url.txt"
  "cUrl-POST-Bundle-cps-bundle-04-to-cps-base-url.txt"
#   "cUrl-POST-Bundle-notification-hospitalx-03-to-cps-base-url.txt"
  "cUrl-GET-cps-task-03-from-cps-base-url.txt"
  "cUrl-GET-cps-questionnaire-patient-details-from-cps-base-url.txt"
  "cUrl-GET-cps-questionnaire-practitioner-details-from-cps-base-url.txt"
  "cUrl-POST-Bundle-cps-bundle-05-to-cps-base-url.txt"
#   "cUrl-POST-Bundle-notification-msc-03-to-cps-base-url.txt"
  "cUrl-GET-cps-task-01-from-cps-base-url.txt"
  "cUrl-PUT-Task-cps-task-01-02-to-cps-base-url.txt"
  "cUrl-GET-cps-careplan-01-from-cps-base-url.txt"
  "cUrl-PUT-CarePlan-cps-careplan-01-02-to-cps-base-url.txt"
  "cUrl-GET-cps-careteam-01-from-cps-base-url.txt"
  "cUrl-PUT-CareTeam-cps-careteam-01-02-to-cps-base-url.txt"
#   "cUrl-POST-Bundle-notification-hospitalx-11-to-cps-base-url.txt"
#   "cUrl-POST-Bundle-notification-msc-11-to-cps-base-url.txt"
)

for value in "${curlstatements[@]}"
do


echo "
Loading file $value"
request=$(<input/images/$value)

# find and replace {{cps-base-url}} with ${CPS_BASE_URL}:
request=${request/"{{cps-base-url}}"/${CPS_BASE_URL}}
request=${request/"{{cpc1-base-url}}"/${CPC1_BASE_URL}}
request=${request/"{{cpc2-base-url}}"/${CPC2_BASE_URL}}

# find and replace {{cps-access-token}} with ${CPS_ACCESS_TOKEN}:
request=${request/"{{cps-access-token}}"/${CPS_ACCESS_TOKEN}}
request=${request/"{{cpc1-access-token}}"/${CPC1_ACCESS_TOKEN}}
request=${request/"{{cpc2-access-token}}"/${CPC2_ACCESS_TOKEN}}

# find and replace backslashes:
request=${request//"\\"/" "}

echo "Request:
$request"
RESPONSE=$($request)
echo "Response:
$RESPONSE"
read -rsp $'Press any key to continue...\n' -n1 key
done

# echo "
# Loading file cUrl-POST-Bundle-cps-bundle-01-to-cps-base-url.txt"
# request=$(<input/images/cUrl-POST-Bundle-cps-bundle-01-to-cps-base-url.txt)

# # find and replace {{cps-base-url}} with ${CPS_BASE_URL}:
# request=${request/"{{cps-base-url}}"/${CPS_BASE_URL}}

# # find and replace {{cps-access-token}} with ${CPS_ACCESS_TOKEN}:
# request=${request/"{{cps-access-token}}"/${CPS_ACCESS_TOKEN}}

# # find and replace backslashes:
# request=${request//"\\"/" "}
# echo "Request:
# $request"
# RESPONSE=$($request)
# echo "Response:
# $RESPONSE"

# echo "
# Loading file cUrl-POST-Bundle-cps-bundle-02-to-cps-base-url.txt"
# request=$(<input/images/cUrl-POST-Bundle-cps-bundle-02-to-cps-base-url.txt)

# # find and replace {{cps-base-url}} with ${CPS_BASE_URL}:
# request=${request/"{{cps-base-url}}"/${CPS_BASE_URL}}

# # find and replace {{cps-access-token}} with ${CPS_ACCESS_TOKEN}:
# request=${request/"{{cps-access-token}}"/${CPS_ACCESS_TOKEN}}

# # find and replace backslashes:
# request=${request//"\\"/" "}
# echo "Request:
# $request"
# RESPONSE=$($request)
# echo "Response:
# $RESPONSE"

# RESPONSE=$(curl --request GET ${CPS_BASE_URL}CarePlan?category=http://snomed.info/sct%7C135411000146103 \
# --header Content-Type:application/json \
# --header 'Authorization: ${CPS_ACCESS_TOKEN}' )
# echo "$RESPONSE"

# echo "Running input/images/cUrl-POST-Bundle-cps-bundle-01-to-cps-base-url.txt"

# request=$(<input/images/cUrl-POST-Bundle-cps-bundle-01-to-cps-base-url.txt)
# request=${request/"{{cps-base-url}}"/"${CPS_BASE_URL}"}
# request=${request/"{{cps-access-token}}"/"${CPS_ACCESS_TOKEN}"}
# echo "Running input/images/cUrl-POST-Bundle-cps-bundle-01-to-cps-base-url.txt 2"
# echo "$request"

# RESPONSE=$($request)
# echo "$RESPONSE"