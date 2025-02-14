### Summary of Provenance in FHIR core spec


### Provenance in Shared Care Planning


The Provenance resource captures details about the creation, modification, and transmission of a resource. It includes information about the entities and agents involved, as well as the time and place of the event. Provenance is essential for understanding the history and trustworthiness of data within healthcare systems. Members of the CareTeam in a CarePlan are authorized to access and manipulate data.  Therefore the transactions that lead to adding or changing CareTeam-members is recorded in Provenance instances. 
Key elements of a Provenance for SCP:
- **target**: The resources that are the subject of the provenance information (e.g., a specific Task).
- **occurredDateTime**: The time period or specific date and time when the event occurred
- **activity**: The type of activity that took place (e.g., creation, modification).
- **agent**: Details about the individual(s) or organization(s) involved in the event, including:
    - **onBehalfOf**: The organization the agent was acting on behalf of.
- **signature**: Digital signatures that authenticate the provenance event.
For more information, check the [FHIR R4 Provenance documentation](https://hl7.org/fhir/R4/provenance.html) and see [this example of a Task with an embedded Provenance instance](https://hl7.org/fhir/R4/task-example1.json.html).