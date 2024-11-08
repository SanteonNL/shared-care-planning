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
* focus.reference = "urn:uuid:cps-servicerequest-telemonitoring"
* reasonCode.coding = $sct#195111005 "Hartfalen"
* for.reference = "urn:uuid:cps-patient-patrick"
* requester.identifier.system = $uzi
* requester.identifier.value = "UZI-1"
* owner.identifier.system = $ura
* owner.identifier.value = "URA-2"


Instance: cps-bundle-01
InstanceOf: Bundle
Usage: #example
Title: "1.03.2 Bundle"
Description: "Bundle to initiate telemonitoring"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntryWithFullurl(urn:uuid:cps-task-01, cps-task-01, #POST, Task)
* insert BundleEntryWithFullurl(urn:uuid:cps-servicerequest-telemonitoring, cps-servicerequest-telemonitoring, #PUT, ServiceRequest?identifier=2.16.528.1.1007.3.3.21514.ehr.orders|99534756439)
* insert BundleEntryWithFullurl(urn:uuid:cps-patient-patrick, cps-patient-patrick, #PUT, Patient?identifier=http://fhir.nl/fhir/NamingSystem/bsn|111222333)


//resulting instances at cps:

Instance: cps-servicerequest-telemonitoring
InstanceOf: ServiceRequest
Usage: #example
Title: "1.03.3 ServiceRequest Telemonitoring"
Description: "copy of data in EHR of Hospital X"
* meta.versionId = "1"
* meta.lastUpdated = "2024-09-03T12:00:00Z"
* identifier.system = "2.16.528.1.1007.3.3.21514.ehr.orders"
* identifier.value = "99534756439"
* status = #active
* intent = #order
* subject.reference = "urn:uuid:cps-patient-patrick"
* encounter.reference = "{{cps-base-url}}Encounter/cps-encounter-01"
* requester.identifier.system = $uzi
* requester.identifier.value = "UZI-1"
* code = http://snomed.info/sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"


Instance: cps-patient-patrick
InstanceOf: Patient
Usage: #example
Title: "1.03.4 Patient Patrick Egger"
Description: "copy of data in EHR of Hospital X"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
* identifier.value = "111222333"
* name
  * given[0] = "Patrick"
  * family = "Egger"
* telecom[+].system = #phone
* telecom[=].value = "+31612345678"
* telecom[+].system = #email
* telecom[=].value = "patrickegger@myweb.nl"
* gender = #male
* birthDate = "1984-04-01"