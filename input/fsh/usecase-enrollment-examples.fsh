
Instance: CarePlan1-v1
InstanceOf: CarePlan
Usage: #example
* meta.versionId = "2"
* meta.lastUpdated = "2024-07-31T14:13:16.748+00:00"
* meta.source = "#Si7v6JGlKSSCX99H"
* status = #active
* intent = #plan
* title = "Care Plan [Chronische obstructieve longaandoening (aandoening)]"
* description = "Care plan description here"
* subject.identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
* subject.identifier.value = "1722435177438"
* careTeam = Reference(CareTeam/4)
* careTeam.type = "CareTeam"
* addresses.identifier.system = "http://snomed.info/sct"
* addresses.identifier.value = "13645005"
* addresses.display = "Chronic obstructive lung disease (disorder)"
* activity.reference = Reference(Task/5)
* activity.reference.type = "Task"


Instance: CareTeam1-v1
InstanceOf: CareTeam
Usage: #example
* meta.versionId = "1"
* meta.lastUpdated = "2024-07-31T14:13:16.303+00:00"
* meta.source = "#gQN90Pvr4k1fHPCn"

// CareTeam1-v2
Instance: CareTeam1-v2
InstanceOf: CareTeam
Usage: #example
* name = "Shared Care Team"
* category = LOINC#LA28865-6 "Longitudinal care-coordination focused care team"
* participant[0].member = Reference(nl-core-CareTeam-01-RelatedPerson-01) "Contact person, Jan de Wit"
* participant[=].member.type = "RelatedPerson"
* participant[+].member = Reference(nl-core-CareTeam-01-Patient-01) "Patient, Ingrid de Jong-de Wit"
* participant[=].member.type = "Patient"
* participant[+].member = Reference(nl-core-CareTeam-01-PractitionerRole-01) "Healthcare professional (role), W. Klaasen, Huisartsen, niet nader gespecificeerd"
* participant[=].member.type = "PractitionerRole"
* participant[+].member = Reference(nl-core-CareTeam-01-PractitionerRole-02) "Healthcare professional (role), S. Curie, Medisch specialisten, geriatrie"
* participant[=].member.type = "PractitionerRole"
* participant[+].member = Reference(nl-core-CareTeam-01-PractitionerRole-03) "Healthcare professional (role), R.M. van Heck, Medisch specialisten, cardiologie"
* participant[=].member.type = "PractitionerRole"
* participant[+].member = Reference(nl-core-CareTeam-01-PractitionerRole-04) "Healthcare professional (role), A. Schele, Medisch specialisten, inwendige geneeskunde"
* participant[=].member.type = "PractitionerRole"
* participant[+].member = Reference(nl-core-CareTeam-01-PractitionerRole-05) "Healthcare professional (role), G.F. de Haan, Apothekers"
* participant[=].member.type = "PractitionerRole"
* reasonReference[0] = Reference(nl-core-CareTeam-01-Condition-01) "Problem, type: Interpretatie van diagnose"
* reasonReference[=].type = "Condition"
* reasonReference[+] = Reference(nl-core-CareTeam-01-Condition-02) "Problem, type: Interpretatie van diagnose"
* reasonReference[=].type = "Condition"
* reasonReference[+] = Reference(nl-core-CareTeam-01-Condition-03) "Problem, type: Complicatie"
* reasonReference[=].type = "Condition"

Instance: Task1-v1
InstanceOf: Task
Usage: #example
* meta.versionId = "1"
* meta.lastUpdated = "2024-07-31T14:13:16.748+00:00"
* meta.source = "#Si7v6JGlKSSCX99H"
* contained = contained-sr
* basedOn = Reference(CarePlan/3)
* basedOn.type = "CarePlan"
* status = #requested
* intent = #order
* focus.type = "Condition"
* focus.identifier.system = "http://snomed.info/sct"
* focus.identifier.value = "13645005"
* input.type = $task-input-type#Reference "Reference"
* input.valueReference = Reference(contained-sr)
* input.valueReference.type = "ServiceRequest"

Instance: contained-sr
InstanceOf: ServiceRequest
Usage: #inline
* meta.source = "#Arre2HmT3kJceTgj"
* status = #active
* intent = #order
* code = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* subject = Reference(Patient/2)
* subject.type = "Patient"
* subject.identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
* subject.identifier.value = "1722435177438"
* requester = Reference(Organization/8) "St. Antonius"
* requester.type = "Organization"
* requester.identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
* requester.identifier.value = "URA-002"
* performer = Reference(Organization/5) "Zorg Bij Jou - Medisch Service Center"
* performer.type = "Organization"
* performer.identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
* performer.identifier.value = "URA-001"
* reasonReference = Reference(Condition/3) "Chronische obstructieve longaandoening (aandoening)"
* reasonReference.type = "Condition"
* reasonReference.identifier.system = "http://fhir.nl/fhir/NamingSystem/condition-identifier"
* reasonReference.identifier.value = "condition-001"



// Task1-v2
// Task1-v2
// Task2-questionnaire1-v1
// Task2-questionnaire1-v2
// Task3-questionnaire1-v1
// Task3-questionnaire1-v2