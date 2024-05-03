This directory contains services for deploying an Orca instance.

## Orchestrator
A service that is used by the local XIS exchange data with a remote XIS.

It knows how to authenticate the user for the remote XIS, where to fetch the data, and how to bundle data when multiple sources are queried. 

## Epic on FHIR Inbound Adapter
A service that handles incoming FHIR data exchanges for the Epic FHIR API as part of an Orca deployment.

## Policy Agent
A service that authorizes inbound data exchanges.