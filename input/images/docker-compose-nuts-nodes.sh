# Please run the following command and replace the HOSPITAL_EXTERNAL_API with the value of the external URL created by ngrok
# ngrok http 8080
# Please run the following command and replace the CPS_EXTERNAL_API with the value of the external URL created by ngrok
# ngrok http 8980

export HOSPITAL_EXTERNAL_API="https://....ngrok-free.app"
export CPS_EXTERNAL_API="https://....ngrok-free.app"

docker compose -f docker-compose-nuts-nodes.yaml up
