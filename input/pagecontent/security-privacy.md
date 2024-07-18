
Shared Care Planning (SCP) is about sharing healthcare data in the context of a patient's care plan. The care organizations involved in SCP participate with a role in SCP to share information between organizations as part of the treatment of the patient. The assumptions of the privacy model are:
* Information is shared between organizations on behalf of the patient's treatment and well being. 
* Both the patient and health care professional have given consent.
* The data shared is limited and specific.
* The trust is of the highest level possible
* All actions and actors are recorded and auditable.

### Consent 

Both the patient and practitioner need to give consent to the exchange of information. The consent of the patient should be requested by the practitioner and recorded in the health care system. Upon enrolling a patient for a use case of SCP, the practitioner provides consent by this action. SCP requires the health care professional to have an active user session where the health care professional is authenticated authorized to initiate such an action. The authentication and authorization credentials MUST be provided to the systems involved in the translation. See the section about [trust](#Trust) form more details.

### Limiting data and access
The access to data in SCP is limited based access policies that apply in the context of data access. The SCP authorization specification makes distinction access policies:
* Care Plan Service Policy: The Shared Care Planing data model elements, being Patient, Task (and other workflow resources), CarePlan and CareTeam based on the role of the participant in the Shared Care Planning. Access rules are based on:
  * The role of the health care professional in the CareTeam of the patient.
  * The FHIR resource type.
  * The action (Read/Create/Update/Delete)
* Care Plan Contributor Policy: The Shared Care Planing specification allows use case specific rules to be defined that limits access to data provided by the Care Plan Contributor based on, and not limited by:
  * Use case
  * Condition 
  * The contents of the CarePlan and CareTeam.
  * Note that the use case specific data is no so much limited to the role of the health care professional in the CareTeam of the patient, as "not looking at the same information" is considered potentially harmful for the patients' treatment. 
The page about [Authorization](authorization.html) provides more detail. 

#### Trust
The SCP makes use of Verifiable Credentials (VCs) and Verifiable Presentations (VPs) as building blocks of Trust over IP to build a hierarchy of trust that creates the fundamentals for data exchange. The main principles are that:
* The user involved in the transaction must be identifiable by all parties involved in the transaction either by directly identifying the user or by substantial cryptographic proof.
* The organization involved in the transaction must be identifiable by cryptographic proof.
The sources of trust SHOULD preferably be trusted third parties, such as the CIBG,

The section on [authentication](authentication.html) describes this subject in more detail.

#### Logging and tracing
Shared Care Planning 

#### Note about Personal information and social security numbers
