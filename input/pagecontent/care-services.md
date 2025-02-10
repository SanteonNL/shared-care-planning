### Introduction

In order to address a (potential) performer, a directory of care services and technical endpoints is required. [IHE mobile Care Service Discovery](https://profiles.ihe.net/ITI/mCSD/ImplementationGuide/ihe.iti.mcsd|3.9.0) specifies such a directory: 
- FHIR Organizations specify care providers and departments within that care provider. 
- FHIR HealthcareServices and/or FHIR PractitionerRole may be used to specify which services are offered by an organization.
- FHIR Locations specify the physical location where a HealthcareService, PractitionerRole or Organization offers services 
- FHIR Endpoints specify the technical location (url) for communication or data exchange.

When a practitioner is creating a Task, it will query the care services directory for the service-type that is requested, possibily within some geographical boundaries (using Location). Once a HealthcareService, PractitionerRole or Organization is selected, a system should lookup the appropriate endpoint/url to send a Task or notification.

SCP does not specify the geographical area of a care service directory. It could cover a small region or multiple countries. A broad scope could improve collaboration between practitioners for patients that are temporarily living abroad, near country borders, suffer from a rare disease or require highly specialized care.

