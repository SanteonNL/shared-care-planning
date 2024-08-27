Instance: cps-careteam1-02
InstanceOf: SCPCareTeam
Usage: #example
Title: "1.02 CareTeam update"
Description: "Update including patient and hospitalx as participant"
* meta.versionId = "2"
* subject = Reference(hospitalx-patrick) 
* subject.display = "Patrick Egger"
* insert ParticipantMember(cps-patrick, Patrick Egger, 2024-08-27)
* insert ParticipantMember(cps-hospitalx, Hospital X, 2024-08-27)
