Instance: cps-careplan-01-02
InstanceOf: SCPCareplan
Usage: #example
Title: "1.12.1 CarePlan update"
Description: "Add activity (Task) to CarePlan"
* meta.versionId = "2"
* status = #active
* intent = #order
* category = $sct#135411000146103 "Multidisciplinary care regime"
* subject.identifier.system = $bsn
* subject.identifier.value = "111222333"
* careTeam = Reference(cps-careteam-01)
* addresses[+] = Reference(cps-heartfailure)
* author.identifier.system = $uzi
* author.identifier.value = "UZI-1"
* activity[+].reference = Reference(cps-task-01)


Instance: cps-careteam-01-02
InstanceOf: SCPCareTeam
Usage: #example
Title: "1.12.2 CareTeam update"
Description: "Add participant to CareTeam"
* meta.versionId = "2"
* category = $sct#135411000146103 "Multidisciplinary care regime"
* subject.identifier.system = $bsn
* subject.identifier.value = "111222333"
* insert ParticipantMember($bsn, 111222333, 2024-08-27)
* insert ParticipantMember($ura, URA-1, 2024-08-27)
* insert ParticipantMember($ura, URA-2, 2024-08-27)



Instance: notification-hospitalx-11
InstanceOf: Bundle
Usage: #example
Title: "1.12.3 notification bundle for Hospital X"
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-notification-r4"
* type = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry.fullUrl = "urn:uuid:292d3c72-edc1-4d8a-afaa-d85e19c7f5611"
* entry.resource = 292d3c72-edc1-4d8a-afaa-d85e19c7f5611
* entry.request.method = #GET
* entry.request.url = "https://cps.nl/fhir/Subscription/cps-sub-hospitalx/$status"
* entry.response.status = "200"

Instance: 292d3c72-edc1-4d8a-afaa-d85e19c7f5611
InstanceOf: Parameters
Usage: #inline
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-status-r4"
* parameter[0].name = "subscription"
* parameter[=].valueReference = Reference(cps-sub-hospitalx)
* parameter[+].name = "status"
* parameter[=].valueCode = #active
* parameter[+].name = "type"
* parameter[=].valueCode = #event-notification
* parameter[+].name = "notification-event"
* parameter[=].part[0].name = "event-number"
* parameter[=].part[=].valueString = "4"
* parameter[=].part[+].name = "timestamp"
* parameter[=].part[=].valueInstant = "2024-05-29T11:44:13.1882432-05:00"
* parameter[=].part[+].name = "focus"
* parameter[=].part[=].valueReference = Reference(cps-careplan-01)
* parameter[+].name = "notification-event"
* parameter[=].part[0].name = "event-number"
* parameter[=].part[=].valueString = "5"
* parameter[=].part[+].name = "timestamp"
* parameter[=].part[=].valueInstant = "2024-05-29T11:44:13.1882432-05:00"
* parameter[=].part[+].name = "focus"
* parameter[=].part[=].valueReference = Reference(cps-careteam-01)

Instance: notification-msc-11
InstanceOf: Bundle
Usage: #example
Title: "1.12.4 notification bundle for MSC"
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-notification-r4"
* type = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry.fullUrl = "urn:uuid:292d3c72-edc1-4d8a-afaa-d85e19c7f5612"
* entry.resource = 292d3c72-edc1-4d8a-afaa-d85e19c7f5612
* entry.request.method = #GET
* entry.request.url = "https://cps.nl/fhir/Subscription/cps-sub-medicalservicecentre/$status"
* entry.response.status = "200"

Instance: 292d3c72-edc1-4d8a-afaa-d85e19c7f5612
InstanceOf: Parameters
Usage: #inline
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-status-r4"
* parameter[0].name = "subscription"
* parameter[=].valueReference = Reference(cps-sub-medicalservicecentre)
* parameter[+].name = "status"
* parameter[=].valueCode = #active
* parameter[+].name = "type"
* parameter[=].valueCode = #event-notification
* parameter[+].name = "notification-event"
* parameter[=].part[0].name = "event-number"
* parameter[=].part[=].valueString = "4"
* parameter[=].part[+].name = "timestamp"
* parameter[=].part[=].valueInstant = "2024-05-29T11:44:13.1882432-05:00"
* parameter[=].part[+].name = "focus"
* parameter[=].part[=].valueReference = Reference(cps-careplan-01)
* parameter[+].name = "notification-event"
* parameter[=].part[0].name = "event-number"
* parameter[=].part[=].valueString = "5"
* parameter[=].part[+].name = "timestamp"
* parameter[=].part[=].valueInstant = "2024-05-29T11:44:13.1882432-05:00"
* parameter[=].part[+].name = "focus"
* parameter[=].part[=].valueReference = Reference(cps-careteam-01)