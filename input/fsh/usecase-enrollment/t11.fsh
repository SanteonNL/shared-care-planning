Instance: cps-task-01-02
InstanceOf: SCPTask
Usage: #example
Title: "1.11 Task acceptance"
Description: "Updating a task for telemonitoring to status accepted"
* meta.versionId = "2"
* status = #accepted
* intent = #order
* code = $task-code#fullfill
* focus = Reference(cps-servicerequest-telemonitoring)
* reasonReference = Reference(cps-heartfailure)
* for.identifier.system = $bsn
* for.identifier.value = "111222333"
* requester.identifier.system = $ura
* requester.identifier.value = "URA-1"
* owner.identifier.system = $ura
* owner.identifier.value = "URA-2"