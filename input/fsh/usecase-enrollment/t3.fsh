Instance: cps-task-02
InstanceOf: SCPTask
Usage: #example
Title: "1.22.1 (sub-)Task 2 creation"
Description: "Ask for extra information for telemonitoring"
* meta.versionId = "1"
* basedOn = Reference(CarePlan/{{careplan1id}})
* partOf = Reference(Task/{{task1id}})
* status = #ready
* intent = #order
* for = Reference(Patient/{{patient1id}})
* requester.identifier.system = $ura
* requester.identifier.value = "URA-2"
* owner.identifier.system = $ura
* owner.identifier.value = "URA-1"
* input[+].type = $task-input-type#Reference "Reference"
* input[=].valueReference = Reference(urn:uuid:msc-telemonitoring-heartfailure-enrollment)

Instance: cps-bundle-02
InstanceOf: Bundle
Usage: #example
Title: "1.22.2 Bundle"
Description: "Bundle to ask for extra information for telemonitoring"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntry(cps-task-02, #POST, Task)
* insert BundleEntryWithFullurl(urn:uuid:msc-telemonitoring-heartfailure-enrollment, msc-telemonitoring-heartfailure-enrollment, #POST, Questionnaire)