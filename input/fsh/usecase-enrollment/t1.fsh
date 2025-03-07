//transaction 1

Instance: cps-task-01
InstanceOf: SCPTask
Usage: #example
Title: "1.03.1 Task creation"
Description: "Initiation of a task for telemonitoring"
* meta.versionId = "1"
* contained[+] = hospitalx-servicerequest-telemonitoring
* contained[+] = hospitalx-user-carolinevandijk
* contained[+] = hospitalx-msc-hcs
* status = #requested
* intent = #order
* code = $task-code#fullfill
* insert RefIdentifierContained(focus, ServiceRequest, hospitalx-servicerequest-telemonitoring, $uuid, urn:uuid:37063bd0-d6bb-4fe0-b73c-26532f297d4b, $ura, URA-1)
* reasonCode.coding = $sct#84114007 "Hartfalen"
* insert RefIdentifier(for, Patient, 1, $bsn, 111222333, $ura, URA-1, org1)
* insert RefIdentifierContained(requester, PractitionerRole, hospitalx-user-carolinevandijk, $uzi, UZI-1, $ura, URA-1)
* insert RefIdentifierContained(owner, HealthcareService, hospitalx-msc-hcs, $uuid, urn:uuid:91a9be09-eb97-4c0f-9a61-27a1985ae38b, $ura, URA-1)
// * relevantHistory[+] = Reference(Provenance/urn:uuid:cps-task-signature-01)


Instance: hospitalx-user-carolinevandijk
InstanceOf: PractitionerRole
Usage: #inline
* identifier[+].system = "https://www.cwz.nl/hix-user"
* identifier[=].value = "123456"
* insert RefIdentifier(organization, Organization, 1, $ura, URA-1, $ura, URA-1, org1)


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


Instance: cps-task-signature-01
InstanceOf: Provenance
Usage: #example
// when deploying resources to a HAPIFHIR-server, it automatrically deletes the _history part (version) of the reference
// to prevent this, the extension "auto-version-references-at-path" is used here
* meta.extension.url = "http://hapifhir.io/fhir/StructureDefinition/auto-version-references-at-path"
* meta.extension.valueString = "target"
* target = Reference(Task/{{task1id}}/_history/{{task1etag}})
* recorded = "2024-12-19T15:41:12+01:00"
* reason = $v3-ActReason#TREAT "treatment"
* activity = $v3-DataOperation#CREATE "create"
* agent.type = $provenance-participant-type#author
* insert RefIdentifier(agent.who, PractitionerRole, 1, $uzi, UZI-1, $ura, URA-1, org1)
* insert RefIdentifier(agent.onBehalfOf, Organization, 1, $ura, URA-1, $ura, URA-1, org1)
* signature.type = urn:iso-astm:E1762-95:2013#1.2.840.10065.1.12.1.5 "Verification Signature"
* signature.when = "2024-12-19T15:41:12+01:00"
* insert RefIdentifier(signature.who, Organization, 1, $ura, URA-1, $ura, URA-1, org1)
* signature.targetFormat = #application/fhir+json
* signature.sigFormat = #application/jose
// signature data created using: https://test.webpki.org/jws-ct/create
// FHIR R6 JSON Signature Rules should be applied: https://build.fhir.org/datatypes.html#JSON 
// copy best practices from: https://hl7.org/fhir/us/davinci-cdex/signatures.html#digital-signatures
* signature.data = "c29tZSBzaWduYXR1cmUgZGF0YQ=="



Instance: cps-auditevent-task-creation
InstanceOf: AuditEvent
Usage: #example
Title: "1.03.5 AuditEvent for Task Creation"
Description: "AuditEvent capturing the creation of a task by organization URA-1"
* meta.versionId = "1"
* type = $audit-event-type#rest "RESTful Operation" //Audit Event: Execution of a RESTful operation as defined by FHIR.
* subtype[+] = $restful-interaction#create "Create" //Create a new resource with a server assigned id.
* action = #C
* recorded = "2024-12-19T15:41:12+01:00"
* outcome = #0
* insert RefIdentifier(agent[0].who, Organization, 1, $ura, URA-1, $ura, URA-1, org1)
* agent[0].requestor = true
* source.observer = Reference(Device/orca-01)
* entity[0].what = Reference(Task/cps-task-01)

// Instance: cps-task-01-ref1
// InstanceOf: SCPTask
// Usage: #example
// Title: "1.03.1 Task creation"
// Description: "Initiation of a task for telemonitoring"
// * meta.versionId = "1"
// * contained[+] = hospitalx-servicerequest-telemonitoring
// * contained[+] = hospitalx-user-carolinevandijk
// * contained[+] = hospitalx-msc-hcs
// * status = #requested
// * intent = #order
// * code = $task-code#fullfill
// * insert RefIdentifierContained(focus, ServiceRequest, hospitalx-servicerequest-telemonitoring, $uuid, urn:uuid:37063bd0-d6bb-4fe0-b73c-26532f297d4b, $ura, URA-1)
// * reasonCode.coding = $sct#84114007 "Hartfalen"
// * insert RefIdentifier(for, Patient, 1, $bsn, 111222333, $ura, URA-1, org1)
// * insert RefIdentifierContained(requester, PractitionerRole, hospitalx-user-carolinevandijk, $uzi, UZI-1, $ura, URA-1)
// * insert RefIdentifierContained(owner, HealthcareService, hospitalx-msc-hcs, $uuid, urn:uuid:91a9be09-eb97-4c0f-9a61-27a1985ae38b, $ura, URA-1)



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