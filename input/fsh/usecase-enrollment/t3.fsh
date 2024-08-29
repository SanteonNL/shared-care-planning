Instance: cps-task1-01
InstanceOf: SCPTask
Usage: #example
Title: "1.03 Task creation"
Description: "Initiation of a task for telemonitoring"
* meta.versionId = "1"
* contained[+] = hospitalx-servicerequest-telemonitoring
* contained[+] = hospitalx-heartfailure
* status = #requested
* intent = #order
* code = $task-code#fullfill
* focus = Reference(hospitalx-servicerequest-telemonitoring)
* reasonReference = Reference(hospitalx-heartfailure)
* for.identifier.system = $bsn
* for.identifier.value = "111222333"
* requester.identifier.system = $ura
* requester.identifier.value = "URA-1"
* owner.identifier.system = $ura
* owner.identifier.value = "URA-2"