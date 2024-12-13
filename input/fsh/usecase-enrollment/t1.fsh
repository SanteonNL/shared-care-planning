//transaction 1

Instance: cps-task-01
InstanceOf: SCPTask
Usage: #example
Title: "1.03.1 Task creation"
Description: "Initiation of a task for telemonitoring"
* meta.versionId = "1"
* status = #requested
* intent = #order
* code = $task-code#fullfill
* insert RefIdentifier(focus, ServiceRequest, 1, $uuid, urn:uuid:37063bd0-d6bb-4fe0-b73c-26532f297d4b, $ura, URA-1, cpc1)
* reasonCode.coding = $sct#195111005 "Hartfalen"
* insert RefIdentifier(for, Patient, 1, $bsn, 111222333, $ura, URA-1, cpc1)
* insert RefIdentifier(requester, PractitionerRole, 1, "http://example.org/hospitalx-HRM/assignments", 123456, $ura, URA-1, cpc1)
* insert RefIdentifier(owner, Organization, 2, $ura, URA-2, $ura, URA-1, cpc1)


// Instance: cps-servicerequest-telemonitoring
// InstanceOf: ServiceRequest
// Usage: #example
// Title: "9.01 ServiceRequest Telemonitoring"
// Description: "Existing data in EHR of Hospital X"
// * meta.versionId = "1"
// * meta.lastUpdated = "2024-09-03T12:00:00Z"
// * status = #active
// * intent = #order
// * subject = Reference(urn:uuid:hospitalx-patient-patrick) 
// * requester = Reference({{cpc1-base-url}}PractitionerRole/{{practitionerrole1id}}) 
// * code = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
// * reasonReference = Reference({{cpc1-base-url}}Condition/{{condition1id}}) 

Instance: cps-bundle-01
InstanceOf: Bundle
Usage: #example
Title: "1.03.2 Bundle"
Description: "Bundle to initiate telemonitoring"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntry(cps-task-01, #POST, Task)
// * insert BundleEntryWithFullurl(urn:uuid:cps-servicerequest-telemonitoring, cps-servicerequest-telemonitoring, #POST, ServiceRequest)
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
// * encounter.reference = "{{cps-base-url}}Encounter/cps-encounter-01"
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