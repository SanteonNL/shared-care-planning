This directory contains services for deploying an Orca instance.

## Orchestrator
A service that is used by the local XIS exchange data with a remote XIS.

It knows how to authenticate the user for the remote XIS, where to fetch the data, and how to bundle data when multiple sources are queried. 

## Epic on FHIR Inbound Adapter
A service that handles incoming FHIR data exchanges for the Epic FHIR API as part of an Orca deployment.

## Policy Agent
A service that authorizes inbound data exchanges.

## Usage
1. Start nutsnode: `docker compose up nutsnode`
2. Run HTTP scripts in `setup-DIDs.http`
3. Take note of DIDs and configure them in `docker-compose.yaml` for orchestrator
4. Start devtunnel on host machine for orchestrator (otherwise devtunnel will break redirection back on localhost): `devtunnel host -a -p 9080`
5. Take note of URL and configure it as `ORCHESTRATOR_BASE_URL` in `docker-compose.yaml` for orchestrator