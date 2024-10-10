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
* focus.identifier.system = "2.16.528.1.1007.3.3.21514.ehr.orders"
* focus.identifier.value = "99534756439"
* reasonReference.identifier.system = "2.16.528.1.1007.3.3.21514.ehr.diagnoses"
* reasonReference.identifier.value = "56476575765"
* for.identifier.system = $bsn
* for.identifier.value = "111222333"
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
* insert BundleEntry(cps-task-01, #PUT, Task/cps-task-01)
* insert BundleEntry(cps-servicerequest-telemonitoring, #PUT, ServiceRequest/2.16.528.1.1007.3.3.21514.ehr.orders-99534756439)
* insert BundleEntry(cps-heartfailure, #PUT, Condition/2.16.528.1.1007.3.3.21514.ehr.diagnoses-56476575765)


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
* subject.identifier.system = $bsn
* subject.identifier.value = "111222333"
* requester.identifier.system = $uzi
* requester.identifier.value = "UZI-1"
* code = http://snomed.info/sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* reasonReference.identifier.system = "2.16.528.1.1007.3.3.21514.ehr.diagnoses"
* reasonReference.identifier.value = "56476575765"

Instance: cps-heartfailure
InstanceOf: Condition
Usage: #example
Title: "1.03.4 Condition heartfailure"
Description: "copy of data in EHR of Hospital X"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
* meta.versionId = "1"
* meta.lastUpdated = "2024-09-03T12:00:00Z"
* identifier.system = "2.16.528.1.1007.3.3.21514.ehr.diagnoses"
* identifier.value = "56476575765"
* code = $sct#195111005 "Hartfalen"
* subject.identifier.system = $bsn
* subject.identifier.value = "111222333"