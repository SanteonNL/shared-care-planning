#!/bin/bash



# Create the environment
# Please modify and run the following script first:
# input/images/docker-compose-nuts-nodes.sh

# Run the following script only once
source input/images/cUrl-POST-Nuts-create-did-and-vcs.sh

# Run the following script to get temporary access tokens
# This script will set:
# CPS_ACCESS_TOKEN
# CPC1_ACCESS_TOKEN
# CPC2_ACCESS_TOKEN
source input/images/cUrl-POST-Nuts-access_tokens.sh

# The FHIR transactions can be tested (partly) by using curl statements that POST/PUT/GET the FHIR example instances in Shared Care Planning to a FHIR server.
# The FHIR instances are generated in JSON format and from FHIR Shorthand (.fsh) files by Sushi

# To install sushi, you need NodeJS, npm and sushi:
  #  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
  #  sudo apt-get install -y nodejs
  #  sudo npm install -g npm@latest
  #  sudo npm install -g fsh-sushi

# To generate the FHIR instances, run the following command (in the root of the repository):
# ~/shared-care-planning$ sushi

# Defining the environment variables for the curl statements
export CPS_BASE_URL="http://localhost:8090/fhir/"
export CPC1_BASE_URL="http://localhost:8190/fhir/"
export CPC2_BASE_URL="http://localhost:8290/fhir/"

curlstatements=(
  "cUrl-POST-Bundle-hospitalx-bundle-01-to-cpc1-fhir-url.txt"
  "cUrl-POST-Bundle-msc-bundle-01-to-cpc2-fhir-url.txt"
  "cUrl-GET-CarePlan-from-org1-fhir-url.txt"
  "cUrl-POST-Bundle-cps-bundle-01-to-org1-fhir-url.txt"
  "cUrl-POST-Subscription-cps-sub-medicalservicecentre-to-org1-fhir-url.txt"
  "cUrl-POST-Subscription-cps-sub-hospitalx-to-org1-fhir-url.txt"
#   "cUrl-POST-Bundle-notification-msc-01-to-org1-fhir-url.txt"
  "cUrl-POST-CareTeam-cps-careteam-01-to-org1-fhir-url.txt"
  "cUrl-POST-CarePlan-cps-careplan-01-to-org1-fhir-url.txt"
#   "cUrl-POST-Bundle-notification-hospitalx-01-to-org1-fhir-url.txt"
  "cUrl-GET-cps-task-01-from-org1-fhir-url.txt"
  "cUrl-GET-cps-servicerequest-telemonitoring-from-org1-fhir-url.txt"
  "cUrl-GET-cps-heartfailure-from-org1-fhir-url.txt"
  "cUrl-POST-Bundle-cps-bundle-02-to-org1-fhir-url.txt"
#   "cUrl-POST-Bundle-notification-hospitalx-02-to-org1-fhir-url.txt"
  "cUrl-GET-cps-task-02-from-org1-fhir-url.txt"
  "cUrl-GET-cps-questionnaire-telemonitoring-enrollment-criteria-from-org1-fhir-url.txt"
  "cUrl-POST-Bundle-cps-bundle-03-to-org1-fhir-url.txt"
#   "cUrl-POST-Bundle-notification-msc-02-to-org1-fhir-url.txt"
  "cUrl-POST-Bundle-cps-bundle-04-to-org1-fhir-url.txt"
#   "cUrl-POST-Bundle-notification-hospitalx-03-to-org1-fhir-url.txt"
  "cUrl-GET-cps-task-03-from-org1-fhir-url.txt"
  "cUrl-GET-cps-questionnaire-patient-details-from-org1-fhir-url.txt"
  "cUrl-GET-cps-questionnaire-practitioner-details-from-org1-fhir-url.txt"
  "cUrl-POST-Bundle-cps-bundle-05-to-org1-fhir-url.txt"
#   "cUrl-POST-Bundle-notification-msc-03-to-org1-fhir-url.txt"
  "cUrl-GET-cps-task-01-from-org1-fhir-url.txt"
  "cUrl-POST-Bundle-cps-bundle-06-to-org1-fhir-url.txt"
  "cUrl-GET-cps-careplan-01-from-org1-fhir-url.txt"
  "cUrl-GET-cps-careteam-01-from-org1-fhir-url.txt"
  "cUrl-POST-Bundle-cps-bundle-07-to-org1-fhir-url.txt"
#   "cUrl-POST-Bundle-notification-hospitalx-11-to-org1-fhir-url.txt"
#   "cUrl-POST-Bundle-notification-msc-11-to-org1-fhir-url.txt"
)

for value in "${curlstatements[@]}"
do


echo "
Loading file $value"
request=$(<input/images/$value)

# find and replace {{org1-fhir-url}} with ${CPS_BASE_URL}:
request=${request/"{{org1-fhir-url}}"/${CPS_BASE_URL}}
request=${request/"{{org1-fhir-url}}"/${CPC1_BASE_URL}}
request=${request/"{{cpc2-fhir-url}}"/${CPC2_BASE_URL}}

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
