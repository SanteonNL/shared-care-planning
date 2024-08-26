Profile: SCPCareplan
Parent: CarePlan
Title: "Shared Care Planning: CarePlan Profile"
Description: "A care plan for a patient that is shared between multiple care providers."
* category = $sct#135411000146103 // Multidisciplinary care regime
* subject only Reference(Patient)
* subject 1..1
* careTeam only Reference(SCPCareTeam)
* careTeam 1..1


Profile: SCPCareTeam
Parent: CareTeam
Title: "Shared Care Planning: CareTeam Profile"
Description: "A care team for a patient that is shared between multiple care providers."
* subject only Reference(Patient)
* subject 1..1
* participant.member 1..1
* participant.period.start 1..1
* participant.period.end 0..1
* managingOrganization 1..1


Profile: SCPTask
Parent: Task
Title: "Shared Care Planning: Task Profile"
Description: "A task for a patient that is shared between multiple care providers."
* ^status = #draft
* ^experimental = true
* basedOn only Reference(SCPCareplan)
* basedOn MS
* status = #ready,#requested,#received,#accepted,#rejected,#in-progress,#on-hold,#completed,#failed,#cancelled,#entered-in-error
* focus MS
