Instance: Task1-v1
InstanceOf: Task
Usage: #example
* meta.versionId = "1"
* meta.lastUpdated = "2024-07-31T14:13:16.748+00:00"
* meta.source = "#Si7v6JGlKSSCX99H"
* contained = servicerequest-telemonitoring
* basedOn = Reference(CarePlan/3)
* basedOn.type = "CarePlan"
* status = #requested
* intent = #order
* focus.type = "Condition"
* focus.identifier.system = "http://snomed.info/sct"
* focus.identifier.value = "13645005"
* input.type = $task-input-type#Reference "Reference"
* input.valueReference = Reference(servicerequest-telemonitoring)
* input.valueReference.type = "ServiceRequest"

// Instance: contained-sr
// InstanceOf: ServiceRequest
// Usage: #inline
// * meta.source = "#Arre2HmT3kJceTgj"
// * status = #active
// * intent = #order
// * code = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
// * subject = Reference(Patient/2)
// * subject.type = "Patient"
// * subject.identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
// * subject.identifier.value = "1722435177438"
// * requester = Reference(Organization/8) "St. Antonius"
// * requester.type = "Organization"
// * requester.identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
// * requester.identifier.value = "URA-002"
// * performer = Reference(Organization/5) "Zorg Bij Jou - Medisch Service Center"
// * performer.type = "Organization"
// * performer.identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
// * performer.identifier.value = "URA-001"
// * reasonReference = Reference(Condition/3) "Chronische obstructieve longaandoening (aandoening)"
// * reasonReference.type = "Condition"
// * reasonReference.identifier.system = "http://fhir.nl/fhir/NamingSystem/condition-identifier"
// * reasonReference.identifier.value = "condition-001"