### Summary of Provenance in FHIR core spec
The FHIR (Fast Healthcare Interoperability Resources) R4 Provenance resource is designed to capture and convey the history of the various entities and processes that contribute to the creation, modification, or deletion of a healthcare resource. It provides a detailed account of the origins and changes to data, ensuring transparency and trustworthiness in healthcare information systems.



### Provenance in Shared Care Planning
The SCP-Careplan typically contains a list of members and activities for a patient. As the CarePlan is updated, it is synchronized to all stakeholders of the CarePlan (using notifications). It can be used to find/locate other data or members and it can be used to autorize data-requests. 
Therefore we should be able to trust the contents of the CarePlan. In other 


  find are used in Shared Care Planning to 


Every creation or update of a SCP-Task or SCP-Careplan MUST 

 Being a member of a CarePlan.careteam can be authorized to access and manipulate data.  Therefore the transactions that lead to adding or changing CareTeam-members is recorded in Provenance instances. 
Key elements of a Provenance for SCP:
- **target**: The resources that are the subject of the provenance information (e.g., a specific Task). The target SHOULD include a version 
- **activity**: The type of activity that took place. To establish/verify an agreement for a referral from one organization to another, at least 2 Provenance records should be present. One at the time of the create (activity: create) by the requester (agent). One at the time of acceptance of the SCP-Task (activity: legal authenticator), it will be created  will MUST be c (e.g., creation, modification).
- **agent**: Details about who was involved in the event. It MUST include **onBehalfOf**: The organization (legal entity) the agent was acting on behalf of.
- **signature**: Digital signatures that authenticate the provenance event.
For more information, check the [FHIR R4 Provenance documentation](https://hl7.org/fhir/R4/provenance.html) and see [this example of a Task with an embedded Provenance instance](https://hl7.org/fhir/R4/task-example1.json.html).