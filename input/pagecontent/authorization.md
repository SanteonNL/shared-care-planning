### The authorization model

The Shared Care Planning (SCP) authorization model is based on the authority of the Care Plan Service (CPS). This service maintains the Care Plan and is responsible for all the due diligence that is required to build up the required trust for all Care Plan Contributors (CPC) in the network.

### Scope of the care plan

#### Bound to the patient
A Care Plan is bound to a patient, and no more than one patient. A Care Plan (CP)  has one single Care Team (CT). Therefore, in CSP the terms Care Plan and Care Team are somewhat interchangeable. 

#### Owned by the Plan Service (CPS)
A Care Plan is created by the Care Plan Service as the owner of a CarePlan. As the care network of the Patient grows, more organization become part of the Care Team
```asciidoc
     ┌───────┐                          
     │Patient│                          
     └───┬───┘                          
         │                              
         │                              
     ┌───┴────┐                         
     │CarePlan┼───────────┬────────┐    
     └───┬────┘           │        │    
         │CPS             │CPC     │CPC 
         │                │        │    
┌────────┴─────────┐ ┌────┴───┐ ┌──┴───┐
│General Practioner│ │Hospital│ │Physio│
└──────────────────┘ └────────┘ └──────┘
```
### A single context of care
A Care Plan is bound to one single context, in the sense that, CSP assumes that all members of the CT are always allowed to access all relevant data. In the case they are not allowed to access all relevant data, they should not be part of the CT. This that case, a different CP should be created. If a patient is referred to another organization that should not have access to all relevant data of the patient, another (nested) CP should be created.

```AsciiDoc
        ┌───────┐                          
┌───────┼Patient│                          
│       └───┬───┘                          
│           │                              
│           │                              
│       ┌───┴────┐                         
│       │CarePlan┼───────────┬────────┐    
│       └───┬────┘           │        │    
│           │CPS             │CPC     │CPC 
│           │                │        │    
│  ┌────────┴─────────┐ ┌────┴───┐ ┌──┴───┐
│  │General Practioner│ │Hospital│ │Physio│
│  └──────────────────┘ └────┬───┘ └──────┘
│                            │             
│                            │CPS          
│                            │             
│                    ┌───────┴───────┐     
└────────────────────┼Nested CarePlan│     
                     └───────┬───────┘     
                             │             
                             │CPC          
                      ┌──────┴──────┐      
                      │Mental health│      
                      │care provider│      
                      └─────────────┘      
```

### Model of Patients' consent
New members can only be added to the Care Team of the Care Plan by with explicit consent of the Patient. This responsibility lies with the Care Plan Service. The CPS must be able to contact the Patient and handle the proces of requesting consent. The same goes for Care Plan Contributors that enter a Care Team with existing data; those must verify with the Patient that the existing data is being shared within the context of the Care Plan and Care Team.

### Methods of Patients' consent
The methods of consent must be either in physical interaction with the Patient (at the desk), by physical channels such as mail or with digital methods such as e-mail or SMS notifications to digital consent forms protected by contemporary authentication methods that are already in place.     

#### (Lack of) cryptographic consent
In the current authentication landscape of the Netherlands, cryptographic proof of end-user consent is not in sight on the short term. The solution we propose is based on a) consent of the user and b) the due-diligence of the CPS and the CPC in some cases. We choose not to put the emphasis on capturing proof of consent with cryptographic methods, knowing that such technology will eventually become part of the EU Digital Identity Wallet infrastructure signing function. 

### Authentication of Organizations
Organizations are authenticated by their X509 Certificate, that is used to sign a X509Credential. This ensures the identity of the health care organizations in Shared Care Planning.


### CPS Responsibilities
The Care Plan Service (SCP) has the role of maintaining the Care Plan and acts as gatekeeper for the Care Plan and Care Team for the Patient. The SCP may only add members to the Care Team with the explicit consent of the user. The CPS may keep track of the consent using the FHIR Consent resources, but is not required to do so.

### CPC Responsibilities
The Care Plan Contributor (CPC) only needs to get consent of the Patient when it links pre-existing data of the Patient to the context of the CarePlan. In that case, the CPC must contact the Patient and is required to get consent for sharing the data.

### The CPS expansion and consent flow

The core flow of consent works a follows:
* A Task is created for a new CPC and that CPC is notified about the Task. Both the CPS or CPC roles can do this. The CPC can either be the initiator of recipient of the Task.
* The CPC either accepts or rejects the Task without knowing the patient.
* The CPS is notified about the accepted Task.
* The CPS contacts the Patient about the new CPC and gets consent on expanding the Care Team.
* The CPS expands the Care Team and notifies the new CPC about the updated CareTeam.
* The new CPC now can fetch the details of the Patient.
* (optional) The CPC can determine the pre-existing data about the patient exists in the system and that this data will be shared within the context of the Care Team. In that case, consent of the patient must be acquired.

#### A more complicated example
{::nomarkdown}
{% include authorization.svg %}
{:/}

The provided **sequence diagram** illustrates the process of adding three external systems (*OLVG*, *Geboortezorg*, and *Fysio*) to a patient's care team. The interactions are handled by the control system (*Huisarts*) and involve patient approval at various stages.

---

## Key Components in the Diagram:

1. **Actors and Entities:**
   - **Patient:** The individual whose care team is being managed.
   - **Huisarts (CPS):** A CPS responsible for the care team management.
   - **OLVG (CPC):** An CPC being added to the care team.
   - **Geboortezorg (CPC):** Another CPC being added.
   - **Fysio (CPC):** A third CPC being added to the care team.

2. **Groups:**  
Each step in the process is organized into groups that represent the task of adding a organization to the care team (*OLVG*, *Geboortezorg*, and *Fysio*).

---

## Process Steps:

### Step 1: Adding **"OLVG"** to the CareTeam
- **Huisarts (CPS) initiates a task** with the *OLVG* system (**CPC**).
- *OLVG* accepts the task and **notifies the Huisarts (CPS)**.
- **The Huisarts (CPS) consults the patient** for approval by sending an consent request.
- Upon patient consent:
  - **The Huisarts (CPS) updates the care team** to include *OLVG*.
  - **The Huisarts (CPS) notifies the OLVG system** of the update.
- *OLVG* then **fetches the patient's details**.

---

### Step 2: Adding **"Geboortezorg"** to the CareTeam
- A new addition starts from *OLVG* (**CPC**), which triggers a task for *Geboortezorg* (**CPC**).
- *Geboortezorg* accepts the task, notifies *OLVG*, and *OLVG* subsequently **notifies the Huisarts (CPS)**.
- **The Huisarts (CPS) consults the patient** for their consent.
- Upon patient consent:
  - **Huisarts (CPS) updates the care team** to include *Geboortezorg*.
  - Notifications are sent to both *OLVG* and *Geboortezorg*.
- *Geboortezorg* **fetches the patient's details** at the Huisarts (CPS).
- If the patient has **existing data**, an additional **consent is required** from the patient. Upon consent, the existing data is handled accordingly.

---

### Step 3: The patient goes to the **Fysio** and names **OLVG**
- *Fysio* (**CPC**) triggers a task for *OLVG* (**CPC**).
- *OLVG* accepts the task, sets the `basedOn` value of the Task to the Care Plan of the CPS and **notifies the Huisarts (CPS)**.
- **The Huisarts (CPS) consults the patient** for consent.
- Upon patient consent:
  - **The Huisarts (CPS) updates the care team** to include *Fysio*.
  - The Huisarts (CPS) sends **notifications to all involved systems** (*OLVG*, *Geboortezorg*, and *Fysio*).
- *Fysio* fetches **the patient's details** from the Huisarts (CPS).
- Additionally:
  - *Fysio* requests **data from *OLVG***.
  - *OLVG* performs an **internal check (CareTeam)** and shares the required **data back to *Fysio***.


### Main advantages of this approach
#### Distributed
As soon as an organization gets assigned a task that is part of SCP, the task refers to the Care Plan with the `basedOn` value. The Care Plan becomes discoverable and the roles in the SCP are implicitly determined by the ownership of the Care Plan. The CPS is the organization hosting the FHIR resource, all the other members are CPC in the Care Plan.

#### Specific
Consent is acquired on adding an organization or existing data to a care plan, and not at forehand.
