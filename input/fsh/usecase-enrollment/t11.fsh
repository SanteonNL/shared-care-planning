Instance: cps-task-01-02
InstanceOf: SCPTask
Usage: #example
Title: "1.11 Task acceptance"
Description: "Updating a task for telemonitoring to status accepted"
* meta.versionId = "2"
* status = #accepted
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