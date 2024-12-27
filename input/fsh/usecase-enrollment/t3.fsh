Instance: cps-task-02
InstanceOf: SCPTask
Usage: #example
Title: "1.22.1 (sub-)Task 2 creation"
Description: "Ask for extra information for telemonitoring"
* meta.versionId = "1"
* contained[0] = msc-telemonitoring-heartfailure-enrollment
* basedOn = Reference(CarePlan/{{careplan1id}})
* partOf = Reference(Task/{{task1id}})
* status = #ready
* intent = #order
* insert RefIdentifier(for, Patient, 1, $bsn, 111222333, $ura, URA-1, org1)
* insert RefIdentifier(requester, Organization, 2, $ura, URA-2, $ura, URA-2, org2)
* insert RefIdentifier(owner, PractitionerRole, 1, $uzi, UZI-1, $ura, URA-2, org2)
* input[+].type = $task-input-type#Reference "Reference"
* input[=].valueReference = Reference(msc-telemonitoring-heartfailure-enrollment)

Instance: cps-bundle-02
InstanceOf: Bundle
Usage: #example
Title: "1.22.2 Bundle"
Description: "Bundle to ask for extra information for telemonitoring"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntry(cps-task-02, #POST, Task)
//* insert BundleEntryWithFullurl(urn:uuid:msc-telemonitoring-heartfailure-enrollment, msc-telemonitoring-heartfailure-enrollment, #POST, Questionnaire)