Profile: SCPCareplan
Parent: CarePlan
Title: "Shared Care Planning: CarePlan Profile"
Description: "A care plan for a patient that is shared between multiple care providers."
* category = $sct#135411000146103 // Multidisciplinary care regime
* subject only Reference(Patient)
* subject 1..1
* careTeam only Reference(SCPCareTeam)
* careTeam 1..1
* author only Reference(PractitionerRole)
* author 1..1


Profile: SCPCareTeam
Parent: CareTeam
Title: "Shared Care Planning: CareTeam Profile"
Description: "A care team for a patient that is shared between multiple care providers."
* subject only Reference(Patient)
* subject 1..1
* participant.member 1..1
* participant.period.start 1..1
* participant.period.end 0..1


Profile: SCPTask
Parent: Task
Title: "Shared Care Planning: Task Profile"
Description: "A task for a patient that is shared between multiple care providers."
* ^status = #draft
* ^experimental = true
* basedOn only Reference(SCPCareplan)
* basedOn MS
* status from SCPTaskStatus (required) 
* focus MS
* for.identifier.system 1..1
* for.identifier.value 1..1
* requester.identifier.system 1..1
* requester.identifier.value 1..1
* owner.identifier.system 1..1
* owner.identifier.value 1..1


ValueSet: SCPTaskStatus
Id: scp-task-status
Title: "Shared Care Planning: Task Status"
* ^status = #active
* include codes from valueset http://hl7.org/fhir/ValueSet/task-status
* exclude $task-status#draft