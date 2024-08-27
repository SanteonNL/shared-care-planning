Instance: cps-task1-01
InstanceOf: SCPTask
Usage: #example
Title: "1.03 Task creation"
Description: "Initiation of a task for telemonitoring"
* meta.versionId = "1"
* contained = hospitalx-servicerequest-telemonitoring
* basedOn = Reference(cps-careplan1-02)
* status = #requested
* intent = #order
* focus = Reference(hospitalx-servicerequest-telemonitoring)
* for = Reference(cps-patrick)
// * input.type = $task-input-type#Reference "Reference"
// * input.valueReference = Reference(hospitalx-servicerequest-telemonitoring)
// * input.valueReference.type = "ServiceRequest"

// Instance: CarePlan1-v2
// InstanceOf: CarePlan
// Usage: #example
// Title: "1.03 CarePlan update"
// Description: "update Careplan after acceptance of Task"
// * meta.versionId = "2"
// * status = #active
// * intent = #order
// * subject.identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
// * subject.identifier.value = "1722435177438"
// * careTeam = Reference(CareTeam/4)
// * addresses.identifier.system = "http://snomed.info/sct"
// * addresses.identifier.value = "13645005"
// * addresses.display = "Chronic obstructive lung disease (disorder)"
// * addresses = Reference(scp-condition-diabetes)
// * supportingInfo = Reference(scp-condition-hypertensie)
// * activity.reference = Reference(Task/5)