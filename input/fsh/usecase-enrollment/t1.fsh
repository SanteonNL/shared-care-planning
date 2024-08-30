//transaction 1

Instance: cps-task1-01
InstanceOf: SCPTask
Usage: #example
Title: "1.01 Task creation"
Description: "Initiation of a task for telemonitoring"
* meta.versionId = "1"
* status = #requested
* intent = #order
* code = $task-code#fullfill
* focus = Reference(urn:oid:456)
* reasonReference = Reference(urn:oid:789)
* for.identifier.system = $bsn
* for.identifier.value = "111222333"
* requester.identifier.system = $uzi
* requester.identifier.value = "UZI-1"
* owner.identifier.system = $ura
* owner.identifier.value = "URA-2"


Instance: cps-bundle1
InstanceOf: Bundle
Usage: #example
Title: "1.01 Bundle"
Description: "Bundle to initiate telemonitoring"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntry(123, cps-task1-01, #PUT, Task)
* insert BundleEntry(456, hospitalx-servicerequest-telemonitoring, #PUT, ServiceRequest)
* insert BundleEntry(789, hospitalx-heartfailure, #PUT, Condition)


//resulting instances at cps:

Instance: cps-servicerequest-telemonitoring
InstanceOf: ServiceRequest
Usage: #example
Title: "1.01 ServiceRequest Telemonitoring"
Description: "copy of data in EHR of Hospital X"
* meta.versionId = "1"
* meta.lastUpdated = "2024-09-03T12:00:00Z"
* meta.source = "http://hospitalx.nl/fhir/ServiceRequest/99534756439"
* status = #active
* intent = #order
* subject = Reference(hospitalx-patrick) "Patient Patrick Egger"
* requester = Reference(hospitalx-carolinevandijk-hospitalx) "Caroline van Dijk at Hospital X"
* code = http://snomed.info/sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* reasonReference = Reference(hospitalx-heartfailure) "Diagnose Hartfalen"

Instance: cps-heartfailure
InstanceOf: Condition
Usage: #example
Title: "9.01 Condition heartfailure"
Description: "copy of data in EHR of Hospital X"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
* meta.versionId = "1"
* meta.lastUpdated = "2024-09-03T12:00:00Z"
* meta.source = "http://hospitalx.nl/fhir/Condition/56476575765"
* code = $sct#195111005 "Hartfalen"
* subject = Reference(hospitalx-patrick)