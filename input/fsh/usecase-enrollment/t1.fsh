//transaction 1

Instance: cps-task-01
InstanceOf: SCPTask
Usage: #example
Title: "1.03.1 Task creation"
Description: "Initiation of a task for telemonitoring"
* meta.versionId = "1"
* meta.implicitRules = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Task"
* status = #requested
* intent = #order
* code = $task-code#fullfill
* insert RefIdentifier(focus, ServiceRequest, 1, $uuid, urn:uuid:37063bd0-d6bb-4fe0-b73c-26532f297d4b, $ura, URA-1, org1)
* reasonCode.coding = $sct#84114007 "Hartfalen"
* insert RefIdentifier(for, Patient, 1, $bsn, 111222333, $ura, URA-1, org1)
* insert RefIdentifier(requester, PractitionerRole, 1, $uzi, UZI-1, $ura, URA-1, org1)
* insert RefIdentifier(owner, Organization, 2, $ura, URA-2, $ura, URA-1, org1)
// * relevantHistory[+] = Reference(Provenance/urn:uuid:cps-task-signature-01)


// Instance: cps-task-signature-01
// InstanceOf: Provenance
// Usage: #inline
// * target = Reference(Task/urn:uuid:cps-task-01)
// * recorded = "2024-12-19T15:41:10+01:00"
// * reason = $v3-ActReason#TREAT "treatment"
// * activity = $v3-DataOperation#CREATE "create"
// * agent.type = $provenance-participant-type#author
// * insert RefIdentifier(agent.who, PractitionerRole, 1, $uzi, UZI-1, $ura, URA-1, org1)
// * insert RefIdentifier(agent.onBehalfOf, Organization, 1, $ura, URA-1, $ura, URA-1, org1)


Instance: cps-bundle-01
InstanceOf: Bundle
Usage: #example
Title: "1.03.2 Bundle"
Description: "Bundle to initiate telemonitoring"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntryWithFullurl(urn:uuid:cps-task-01,cps-task-01, #POST, Task)
// * insert BundleEntryWithFullurl(urn:uuid:cps-task-signature-01, cps-task-signature-01, #POST, Provenance)
// * insert BundleEntryWithFullurl(urn:uuid:hospitalx-patient-patrick, hospitalx-patient-patrick, #POST, Patient)


// //resulting instances at cps:

// Instance: cps-servicerequest-telemonitoring
// InstanceOf: ServiceRequest
// Usage: #example
// Title: "1.03.3 ServiceRequest Telemonitoring"
// Description: "copy of data in EHR of Hospital X"
// * meta.versionId = "1"
// * meta.lastUpdated = "2024-09-03T12:00:00Z"
// * identifier.system = "2.16.528.1.1007.3.3.21514.ehr.orders"
// * identifier.value = "99534756439"
// * status = #active
// * intent = #order
// * subject.reference = "urn:uuid:cps-patient-patrick"
// * encounter.reference = "{{org1-fhir-url}}Encounter/cps-encounter-01"
// * requester.identifier.system = $uzi
// * requester.identifier.value = "UZI-1"
// * code = http://snomed.info/sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"


// Instance: cps-patient-patrick
// InstanceOf: Patient
// Usage: #example
// Title: "1.03.4 Patient Patrick Egger"
// Description: "copy of data in EHR of Hospital X"
// * meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient"
// * identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
// * identifier.value = "111222333"
// * name
//   * given[0] = "Patrick"
//   * family = "Egger"
// * telecom[+].system = #phone
// * telecom[=].value = "+31612345678"
// * telecom[+].system = #email
// * telecom[=].value = "patrickegger@myweb.nl"
// * gender = #male
// * birthDate = "1984-04-01"