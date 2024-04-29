# Epic on FHIR Inbound Adapter
This application handles incoming FHIR data exchanges for the Epic XIS as part of an Orca deployment.
It authenticates to the Epic on FHIR API through SMART on FHIR OAuth2 Backend.

See https://fhir.epic.com/Documentation?docId=oauth2&section=BackendOAuth2Guide

## Epic Sandbox URLs

https://open.epic.com/MyApps/Endpoints

Sandbox R4 conformance statement: https://fhir.epic.com/interconnect-fhir-oauth/api/FHIR/R4/metadata
SMART Configuration: https://fhir.epic.com/interconnect-fhir-oauth/api/FHIR/R4/.well-known/smart-configuration

## Not supported / TODO
- Token refresh: https://build.fhir.org/ig/HL7/smart-app-launch/app-launch.html#refresh-access-token