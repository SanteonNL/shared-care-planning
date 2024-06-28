# Introduction

Shared Care Planning (SCP) provides the structures and transactions for care
planning, collaboration between practitioners by cross-organizational ordering processes and localization and authorization of members involved in the careteam of a patient. Improved collaboration between different types of care providers (e.g. GP, homecare or hospitals) should improve efficiency in hybrid or network-care settings. It should lower the administrative burden for practitioners without having to switch to auxillary collaboration-systems.

SCP builds upon the IHE 'Dynamic Care Planning' profile (IHE-DCP). It is extended by generic, FHIR workflow patterns for cross-organizational requests or orders. An authorization model will also be provided so that members in a distributed careteam will, e.g., be able to read patient-data from other organizations and/or will be able to plan new activities.


# Concepts

This IG uses several concepts from the FHIR R4 specifications. 

## FHIR Restful interactions
In the transactions sections, this IG will use the [basic concepts on RESTful interaction with a FHIR API](https://hl7.org/fhir/R4/http.html); e.g. read, search, update, create and delete iinteractions
> [!IMPORTANT] 
> To avoid losing data during update, actors MUST support the directives in  [transactional integrity](http://hl7.org/fhir/R4/http.html#transactional-integrity) and [concurrency](https://hl7.org/fhir/R4/http.html#concurrency)

## FHIR Workflow
This IG will use and specify a workflow pattern. For general FHIR workflow concepts, see: https://hl7.org/fhir/R4/workflow.html The base pattern that will be used is the [https://hl7.org/fhir/R4/workflow-management.html#optionh](https://hl7.org/fhir/R4/workflow-management.html#optionh)


## FHIR Resource types
The IG is referring to many FHIR resource types. A quick summary:

### CarePlan
The FHIR CarePlan resource is a comprehensive framework for documenting and managing healthcare interventions and goals. It ensures that all relevant information is available to all stakeholders, promoting coordinated and effective care delivery. Key elements of a CarePlan for SCP:
- **subject**: The patient to whom the care plan is intended.
- **addresses**: Conditions/problems/concerns/diagnoses that this plan is addressing.
- **careTeam**: All the individuals and organizations who are expected to be involved in the care plan’s execution.
- **goal**: The intended outcomes or objectives of the care plan.
- **activity**: Details of the planned interventions, including scheduled activities, performed activities, and their outcomes.
- **author**: The person or organization that authored the care plan.
https://hl7.org/fhir/R4/careplan.html

## CareTeam
https://hl7.org/fhir/R4/careteam.html

## Patient
https://hl7.org/fhir/R4/patient.html

## Task
https://hl7.org/fhir/R4/task.html see the state machine: https://hl7.org/fhir/R4/workflow-communications.html#12.6.2

## PlanDefinition
https://hl7.org/fhir/R4/plandefinition.html

## ActivityDefinition
https://hl7.org/fhir/R4/activitydefinition.html

## AuditEvent
https://hl7.org/fhir/R4/auditevent.html

# Actors
There are three actors in this Implementation Guide. The first actor is the Care Plan Contributor. This actor interacts with both the Care Plan Service and the Care Plan Definition Service. This actor creates and updates the care plan and tasks/orders for other Care Plan Contributors, 

The second actor is the Care Plan Service. This actor manages patient specific Care Plans, Tasks and Care Teams. The Care Plan Service is also responsible for updating several elements in Care Plans and Care Teams that authorize new practitioners in the Care Teams.

The third actor is the Care Plan Definition Service. This actor manages Plan Definitions and Activity Definitions that are used for order sets, protocols, clinical practice guidelines, etc.
Each actor is described in detail below. 


## Care Plan Contributor

CarePlan kunnen POSTen naar CPS
Task kunnen POSTen naar CPS
notificatie kunnen ontvangen van Task
Optioneel: subscription nemen/notificatie ontvangen voor CarePlan/CareTeam
Data ontsluiten uit FHIR endpoint
Autorisatie op data-ontsluiting o.b.v. CarePlan/CareTeam (optioneel: gebruik van CPC $authorize)
Lokaliseren&ophalen van data o.b.v. CarePlan/CareTeam (optioneel: gebruik van CPC $localize)
TODO: CapabilityStatement maken voor CPC zoals https://profiles.ihe.net/ITI/mCSD/CapabilityStatement-IHE.mCSD.CareServicesSelectiveConsumer.html 



## Care Plan Service

 Alle Tasks bij de CPS posten/updaten (en placer of owner automatisch notificeren, behalve als ontvanger=verzender; als je zelf de CPS bent
Maak b.v. AuditEvent van een Task-request, Task-acceptance, Task-cancellation, etc. Daarna proces bouwen dat bij iedere Task wijziging checkt of o.b.v. Task&AuditEvents het CarePlan/CareTeam moet wijzigen
Voor CarePlan-merge ook Task aanmaken vanuit/naar CarePlan-X-eigenaar of Careplan-Y-eigenaar (ook request/acceptance vastleggen)
Iets met hoofdbehandelaarschap doen? (met Task overdragen?)
Operation $authorize: gesloten autorizatievraag: mag deze zorgverlener van organizatie 123 ihkv het CarePlan X data opvragen (welke data?)
Operatie $localize: geef me endpoints (of URA's) voor CarePlan X

TODO: CapabilityStatement maken voor CPS zoals https://profiles.ihe.net/ITI/mCSD/CapabilityStatement-IHE.mCSD.CareServicesSelectiveSupplier.html

## Plan Definition Service

Hoeft niet zo veel te kunnen; hosten van PlanDefinition en ActivityDefinitions

# Security considerations

## Identification and authentication
Data push or data pull of Personally Identifiable Information (PII) should always be initiated by a Practitioner; should be auditable who has done stuff.

Refer to Trust-over-IP or ARF or something

## Authorization
Authorization; based on conditions, task-type, careteam-member-status (active/inactive) and/or role
Member(-status) in the CareTeam are only updated by the CPS after 'agreement' on a Task in the CarePlan. 

# Transactions

There are four(?) transactions in SCP.
1. Task negotiation
1. CarePlan and CareTeam management (for autorization and localization)
1. Localization of CareTeam members and Patient Information
1. Autorization of CareTeam members using Patient Information

Zie voor structuur: https://profiles.ihe.net/ITI/mCSD/ITI-90.html


Generic requirement for updates:
In order to ensure data integrity, as is necessary when multiple Care Plan Contributors are attempting to update the same Care Plan, the Care Plan Contributor SHALL use the following pattern (from http://hl7.org/fhir/R4/http.html#transactional-integrity):
- Before updating, the actor SHALL read the latest version of the instance;
- The actor SHALL apply the changes (additions, updates, deletions) it wants to the instance, leaving all other information intact;
- The actor SHALL write the instance back as an update interaction, and
is able to handle a failure response, commonly due to other Contributor Updates (usually by trying again)
TODO: https://hl7.org/fhir/http.html#concurrency


## Task negotiation and addressing care providers

For adressing: make use of a (nation wide) database where you can find healthcareservices and or organizations that you are looking for. Tip: implement/use a Care Service Discovery that conforms to the [IHE mCSD](https://profiles.ihe.net/ITI/mCSD/index.html) profile

For resolving a FHIR-endpoint for a specific healthcareservice/organization, multiple service discovery methods could be used (NUTS en/of GF Adressering)

> [!IMPORTANT] 
> This transaction will involve notification of the Task. Depending on the usecase, this might include sending/pushing PHI to other parties. The sending party must verify that the endpoint to which the data is sent, is under control of the intended recipient party.


### Trigger Events
geen; handmatig?
### Scope


### Actor Roles

### Interactions 
Sequence diagram

### Profiles
Task profile met verplichte referentie naar CarePlan in .BasedOn en request in .focus ??? Constraints zetten op referentie naar .owner (moet opgehaald kunnen worden door CPS). 
TODO: refer to used profiles (FHIR structure definitions generated on page 'Artifacts')

## CarePlan and CareTeam management for autorization and localization

### Trigger Events
Task met status 'accepted', 'cancelled', 'completed', etc.

### Scope

### Actor Roles

### Interactions 
Sequence diagram

### Profiles
TODO: refer to used profiles (FHIR structure definitions generated on page 'Artifacts')


## Localization of CareTeam members and Patient Information

### Trigger Events

### Scope

### Actor Roles

### Interactions 

### Profiles
TODO: refer to used profiles (FHIR structure definitions generated on page 'Artifacts')

## Autorization of CareTeam members using Patient Information

### Trigger Events

### Scope

### Actor Roles

### Interactions 

### Profiles
TODO: refer to used profiles (FHIR structure definitions generated on page 'Artifacts')


# Deployment considerations
use Orca and you'll be fine.

# Overview of the documentation structure

The image below displays the schematic overview of the topics.

Legenda
- Light green, existing standards that don't need a specific description of the usage.
- Dark green, existing standards that need a specific description of the usage.
- Blue, the topics that need description.

# Related Standards

TODO Review text:
In bovenstaande specificatie beschrijft een implementatie van het IHE DCP profiel. Deze specificatie breidt het IHE profile uit met de data die binnen werkprocessen (en tussen organisaties) ontstaat en de afgeleide, functionele autorisatie voor deze data. Uiteraard zijn er andere standaarden binnen de zorg die een overlap hebben met deze specificatie. Bij het opstellen van deze specificatie is getracht om zo veel mogelijk deze bestaande standaarden te hergebruiken.

## IHE: DCP
This specification has copied many of the concepts used in IHE DCP. However.... describe difference

## US: Bi-directional ServiceRequest (BSER)

## NL: eOverdracht
[TODO: beschrijving overeenkomsten en verschillen met eOverdracht standaard]


## NL: Koppeltaal 2.0
[TODO: beschrijving overeenkomsten en verschillen met Koppeltaal 2.0 standaard]

## NL: Technical Agreement Notified Pull
[TODO: beschrijving overeenkomsten en verschillen met TA NP standaard]