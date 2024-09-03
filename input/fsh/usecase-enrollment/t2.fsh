Instance: cps-careplan1-01
InstanceOf: SCPCareplan
Usage: #example
Title: "1.02 CarePlan creation"
Description: "Initiation of a care plan for a patient with Heartfailure"
* meta.versionId = "1"
* status = #active
* intent = #order
* category = $sct#135411000146103 "Multidisciplinary care regime"
* subject.identifier.system = $bsn
* subject.identifier.value = "111222333"
* careTeam = Reference(cps-careteam1-01)
* addresses[+] = Reference(cps-heartfailure)
* author.identifier.system = $uzi
* author.identifier.value = "UZI-1"


Instance: cps-careteam1-01
InstanceOf: SCPCareTeam
Usage: #example
Title: "1.02 CareTeam creation"
Description: "Initiation of a care team for a patient with Heartfailure"
* meta.versionId = "1"
* category = $sct#135411000146103 "Multidisciplinary care regime"
* subject.identifier.system = $bsn
* subject.identifier.value = "111222333"
* insert ParticipantMember($bsn, 111222333, 2024-08-27)
* insert ParticipantMember($ura, URA-1, 2024-08-27)