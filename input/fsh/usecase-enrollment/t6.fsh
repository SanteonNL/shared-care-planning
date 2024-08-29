Instance: cps-task1-02
InstanceOf: SCPTask
Usage: #example
Title: "1.03 Task creation"
Description: "Initiation of a task for telemonitoring"
* meta.versionId = "1"
* contained = hospitalx-servicerequest-telemonitoring
* basedOn = Reference(cps-careplan1-02)
* status = #accepted
* intent = #order
* focus = Reference(hospitalx-servicerequest-telemonitoring)
* for = Reference(cps-patrick)