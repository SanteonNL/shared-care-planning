# Shared Care Planning

## Introduction

## Terminology

## Processes

### Workflow
Nodig:
Patient
ServiceRequest (of andere 'request-resource') met referentie naar PractitionerRole en Organization van aanvragende en uitvoerende partij
Indien CarePlan bekend: CarePlan, anders: relevante Condition(s)
Optioneel: Task. Indien Task ontbreekt, wordt deze aangemaakt als dit lokaal mogelijk is.

### Viewing data

## Data Exchange Patterns

### Push
The act of sending unsolicited data to another party.

#### Requirements
The sending party must verify that the endpoint to which the data is sent, is under control of the intended recipient party.

### Notified Pull
TODO: Is it conform the TA NP, or another NP flavor?

## Security

### Identification and Authentication
The act of identifying the parties involved in the data exchange:

- Care organizations
- Care professionals

### Authorization
The act of determining what data can be exchanged between the parties.

## Localization
The act of finding parties that hold data for a specific patient.

## Addressing
The act of finding the technical endpoint.

### Traceability

## Logging
The act of recording the data exchange.
