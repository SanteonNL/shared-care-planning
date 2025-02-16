### Summary of IHE mobile Care Service Discovery
The [IHE mCSD (Mobile Care Services Discovery)](https://profiles.ihe.net/ITI/mCSD/ImplementationGuide/ihe.iti.mcsd|3.9.0) specification is part of the Integrating the Healthcare Enterprise (IHE) initiative. It focusses on how it enables healthcare organizations to discover and address care services. It includes FHIR R4-based resourcetypes Organization, OrganizationAffiliation, Location, Practitioner, PractitionerRole, HealthcareService and Endpoints. IHE mCSD has defined profiles for concepts Facility and Jurisdiction.
IHE mCSD uses standard FHIR REST queries to, periodically, collect/update all resources in a central (e.g. National) repository. It also uses standard FHIR REST queries to search/select resources from a central repository. Key features for resourcetypes used in SCP:
- Organization: Organizations are “umbrella” entities; these may be considered the administrative bodies under whose auspices care services are provided. An organization has a unique identifier and may have additional administrative attributes such as contact person, mailing address, etc. Departments of an institution, or other administrative units, may be represented as child Organizations of a parent Organization.
- Practitioner – A Practitioner is a health worker such as defined by WHO (in Chapter 1 of the World Health Report 2006); a Practitioner might be a physician, nurse, pharmacist, community health worker, district health manager, etc. Practitioners have contact and demographic attributes. Each Practitioner may be related to one or more Organizations, one or more Locations and one or more Healthcare Services. Specific attributes (type/role) may be associated with the Practitioner relationship with an Organization in a PractitionerRole resource.
- Healthcare Service – Each healthcare service has a unique identifier. Examples include surgical services, antenatal care services, or primary care services. The combination of a Healthcare Service offered at a Location may have specific attributes including contact person, hours of operation, etc.
- Location – Locations are physical places where care can be delivered such as buildings, wards, rooms, or vehicles. A Location has a unique identifier and may have geographic attributes (address, geocode), attributes regarding its hours of operation, etc. Each Location may be related to one Organization. A location may have a hierarchical relationship with other locations.
- Endpoint - An Organization may be reachable for electronic data exchange through electronic Endpoint(s). An Endpoint may be a FHIR server, an IHE web services actor, or some other mechanism. If an Organization does not have an Endpoint, it may still be reachable via an Endpoint at its parent Organization or an affiliated Organization.

### Care Service Discovery in Shared Care Planning
In Shared Care Planning, information is needed to discover or address other care providers, departments or practitioners that are relevant for the patient. For this, the FHIR R4 resources Organization, PractitionerRole, HealthcareServices, Location and Endpoint are used. The first three resourcestypes provide information for the *type* of organization, type of practitioners and (healthcare-) services offered. Resourcetypes Location and Endpoint provide information on the geographical/physical or digital/virtual *location* of the entity.

A SCP node must register and publish entities (Locations, HealthcareServices, etc.) that exist in the local organization. 

A Care Service Directory collects all entities periodically from all SCP nodes. In oreder to do that, the Care Service Directory needs a list of all organizations/endpoints in scope of the CSD.

The SCP node uses the Care Service Directory to select or search for e.g. HealthcareServices or Endpoints that it needs. 

In practice, there are many deployment optionns. In theory, every SCP node could perform the role of a Care Service Directory, but that would be an inefficient, not-very-scalable approach. You could also have 1 central CSD, but that would result in being highly dependant on that single service (single point of failure). Hybrid approaches are also possible where, e.g., a central CSD node periodically collects all entities and SCP nodes copy the CSD to a local repository.

### example use case
#### Use Case #1: Practitioner Query
The patient, Vera Brooks, consults with her physician who recommends surgery. The physician can assist the patient in finding a suitable surgeon, taking into consideration the location and specialty of the surgeon.
- Vera Brooks sees her family physician, Dr. West, regarding a recent knee injury.
- Dr. West diagnoses the problem as a torn ACL and decides to refer Vera to an orthopedic surgeon.
- Dr. West uses her EHR query tool, which implements a Care Services Selective Consumer to search for orthopedic surgeons within 30km of Vera’s home.
- The EHR retrieves the information from a Care Service Directory and displays it to Dr. West.
- Vera and Dr. West decide on an orthopedic surgeon Dr. East; Dr. West prepares a referral.
<div>
{% include care-services-use-case-1.svg %}
</div>

#### Use Case #2: Endpoint Discovery
Dr. West just created a referral (for patient Vera Brooks from use case #1). The EHR has to notify the Orthopedic clinic of this referral. This may include some recurring requests:
- The EHR looks up the PractionerRole instance of Dr. East at the CSD, fetches related endpoints and checks if these are capable of receiving SCP notifications. If none found:
    - The EHR looks up the associated Organization of the PractionerRole at the CSD, fetches related endpoints and checks if these are capable of receiving SCP notifications. If none found:
        - The EHR looks up the associated/parent Organization of the Organization at the CSD, fetches related endpoints and checks if these are capable of receiving SCP notifications. If none found: repeat last step.
- As soon as an endpoint is found, the EHR sends the notification and referral-workflow continues.

<div>
{% include care-services-use-case-2.svg %}
</div>

### requirements for a SCP endpoint
A SCP endpoint will perform the IHE mCSD role of 'Care Services Update Supplier'. A SCP node must register and publish entities (Locations, HealthcareServices, etc.) that exist in the local organization. The entities will be collected by a Care Service Directory using a history-search, getting all changes since a specific datetime.

A Shared Care Planning **endpoint** shall implement the following capabilities:
- support the `Organization`, `Location`, `Practitioner`, `PractitionerRole`, `HealthcareService`, `Endpoint` resources
    - support the `history-type` interaction
        - support searchparameter `_since`

### requirements for SCP node
A SCP node/client will perform the IHE mCSD role of 'Care Services Selective Consumer'. It should enable a practitioner, like [Dr. West in use case 1](#use-case-1-practitioner-query), to search for other care services or to find the endpoint for a, e.g., department (organization). The SCP node should basically be able to use the collected data in the CSD.
 


### requirements for a Care Service Directory endpoint

A CSD endpoint will perform the IHE mCSD role of 'Care Services Selective Supplier':

- support searchparameters `_id` and `_lastUpdated`
- support the `Organization` resource
    - support the `search-type` interaction
        - support searchparameters `active`,`identifier`, `name`, `name:contains`, `name:exact`, `partof`, `type`
        - supports including references at `Organization.endpoint`
- support the `Location` resource
    - support the `search-type` interaction
        - support searchparameters `near`,`near-distance`, `identifier`, `name`, `name:contains`, `name:exact`, `organization`, `partof`, `type`, `status`
        - supports including references at `Location.organization`
- support the `Practitioner` resource
    - support the `search-type` interaction
        - support searchparameters `active`,`identifier`, `name`, `name:contains`, `name:exact`, `given`, `given:contains`, `given:exact`,`family`, `family:contains`, `family:exact`,
- support the `PractitionerRole` resource
    - support the `search-type` interaction
        - support searchparameters `active`,`location`, `organization`, `role`, `service` and `specialty`
        - supports including references at `PractitionerRole.practitioner`
- support the `HealthcareService` resource
    - support the `search-type` interaction
        - support searchparameters `active`,`identifier`, `location`, `name`, `name:contains`, `name:exact`, `organization` and `service-type`
- support the `Endpoint` resource
    - support the `search-type` interaction
        - support searchparameters `identifier`,`organization` and `status`


### requirements for Care Service Directory service

A CSD node/client will perform the IHE mCSD role of 'Care Services Update Consumer'. It should periodically loop through all SCP node and fetch any changes in the registered entities and merging those in the repoository of the CSD. 
