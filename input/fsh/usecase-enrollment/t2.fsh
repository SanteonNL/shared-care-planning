Instance: cps-sub-medicalservicecentre
InstanceOf: Subscription
Usage: #example
Title: "1.04.1 Subscription Medical Service Centre"
Description: "Subscription to receive notifications of instance-id's where the Medical Service Centre is a participant. E.g. as a CareTeam.participant.member, Task.owner or Task.filler"
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription"
* status = #active
* reason = "Subscription to receive notifications of instance-id's where the Medical Service Centre is a participant. E.g. as a CareTeam.participant.member, Task.owner or Task.filler"
* criteria = "https://cps.nl/fhir/SubscriptionTopic/organizationIsParticipantInInstance"
* criteria.extension.url = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-filter-criteria"
* criteria.extension.valueString = "Task?owner.identifier=http://fhir.nl/fhir/NamingSystem/ura|URA-1,Task?requester.identifier=http://fhir.nl/fhir/NamingSystem/ura|URA-1,CareTeam?participant.member.identifier=http://fhir.nl/fhir/NamingSystem/ura|URA-1"
* channel.extension[0].url = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-heartbeat-period"
* channel.extension[=].valueUnsignedInt = 86400
* channel.extension[+].url = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-timeout"
* channel.extension[=].valueUnsignedInt = 60
* channel.extension[+].url = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-max-count"
* channel.extension[=].valuePositiveInt = 20
* channel.type = #rest-hook
* channel.endpoint = "{{cpc2-base-url}}notifications"
* channel.payload = #application/fhir+json
* channel.payload.extension.url = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-payload-content"
* channel.payload.extension.valueCode = #id-only

Instance: cps-sub-hospitalx
InstanceOf: Subscription
Usage: #example
Title: "1.04.2 Subscription Hospital X"
Description: "Subscription to receive notifications of instance-id's where Hospital X is a participant. E.g. as a CareTeam.participant.member, Task.owner or Task.filler"

* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription"
* status = #active
* reason = "Subscription to receive notifications of instance-id's where Hospital X is a participant. E.g. as a CareTeam.participant.member, Task.owner or Task.filler"
* criteria = "https://cps.nl/fhir/SubscriptionTopic/organizationIsParticipantInInstance"
* criteria.extension.url = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-filter-criteria"
* criteria.extension.valueString = "Task?owner.identifier=http://fhir.nl/fhir/NamingSystem/ura|URA-2,Task?requester.identifier=http://fhir.nl/fhir/NamingSystem/ura|URA-2,CareTeam?participant.member.identifier=http://fhir.nl/fhir/NamingSystem/ura|URA-2"
* channel.extension[0].url = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-heartbeat-period"
* channel.extension[=].valueUnsignedInt = 86400
* channel.extension[+].url = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-timeout"
* channel.extension[=].valueUnsignedInt = 60
* channel.extension[+].url = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-max-count"
* channel.extension[=].valuePositiveInt = 20
* channel.type = #rest-hook
* channel.endpoint = "{{cpc1-base-url}}notifications"
* channel.payload = #application/fhir+json
* channel.payload.extension.url = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-payload-content"
* channel.payload.extension.valueCode = #id-only




Instance: cps-careplan-01
InstanceOf: SCPCareplan
Usage: #example
Title: "1.04.3 CarePlan creation"
Description: "Initiation of a care plan for a patient with Heartfailure"
* meta.versionId = "1"
* status = #active
* intent = #order
* category = $sct#135411000146103 "Multidisciplinary care regime"
* subject = Reference(Patient/{{patient1id}})
* careTeam = Reference(CareTeam/{{careteam1id}})
* author.identifier.system = $uzi
* author.identifier.value = "UZI-1"


Instance: cps-careteam-01
InstanceOf: SCPCareTeam
Usage: #example
Title: "1.04.4 CareTeam creation"
Description: "Initiation of a care team for a patient with Heartfailure"
* meta.versionId = "1"
* category = $sct#135411000146103 "Multidisciplinary care regime"
* subject = Reference(Patient/{{patient1id}})
* insert ParticipantMember($bsn, 111222333, 2024-08-27)
* insert ParticipantMember($ura, URA-1, 2024-08-27)


Instance: notification-hospitalx-01
InstanceOf: Bundle
Usage: #example
Title: "1.05.1 notification bundle for Hospital X"
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-notification-r4"
* type = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry.fullUrl = "urn:uuid:292d3c72-edc1-4d8a-afaa-d85e19c7f562a"
* entry.resource = 292d3c72-edc1-4d8a-afaa-d85e19c7f562a
* entry.request.method = #GET
* entry.request.url = "{{cps-base-url}}Subscription/{{subscription1id}}/$status"
* entry.response.status = "200"

Instance: 292d3c72-edc1-4d8a-afaa-d85e19c7f562a
InstanceOf: Parameters
Usage: #example
Title: "1.05.2 notification bundle parameter for Hospital X"
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-status-r4"
* parameter[0].name = "subscription"
* parameter[=].valueReference = Reference({{cps-base-url}}Subscription/{{subscription1id}})
* parameter[+].name = "status"
* parameter[=].valueCode = #active
* parameter[+].name = "type"
* parameter[=].valueCode = #event-notification
* parameter[+].name = "notification-event"
* parameter[=].part[0].name = "event-number"
* parameter[=].part[=].valueString = "1"
* parameter[=].part[+].name = "timestamp"
* parameter[=].part[=].valueInstant = "2024-05-29T11:44:13.1882432-05:00"
* parameter[=].part[+].name = "focus"
* parameter[=].part[=].valueReference = Reference({{cps-base-url}}CarePlan/{{careplan1id}})
* parameter[+].name = "notification-event"
* parameter[=].part[0].name = "event-number"
* parameter[=].part[=].valueString = "2"
* parameter[=].part[+].name = "timestamp"
* parameter[=].part[=].valueInstant = "2024-05-29T11:44:13.1882432-05:00"
* parameter[=].part[+].name = "focus"
* parameter[=].part[=].valueReference = Reference({{cps-base-url}}CareTeam/{{careteam1id}})

Instance: notification-msc-01
InstanceOf: Bundle
Title: "1.06 notification bundle for MSC"
Usage: #example
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-notification-r4"
* type = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry.fullUrl = "urn:uuid:292d3c72-edc1-4d8a-afaa-d85e19c7f562"
* entry.resource = 292d3c72-edc1-4d8a-afaa-d85e19c7f562
* entry.request.method = #GET
* entry.request.url = "{{cps-base-url}}Subscription/{{subscription2id}}/$status"
* entry.response.status = "200"

Instance: 292d3c72-edc1-4d8a-afaa-d85e19c7f562
InstanceOf: Parameters
Usage: #inline
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-status-r4"
* parameter[0].name = "subscription"
* parameter[=].valueReference = Reference({{cps-base-url}}Subscription/{{subscription2id}})
* parameter[+].name = "status"
* parameter[=].valueCode = #active
* parameter[+].name = "type"
* parameter[=].valueCode = #event-notification
* parameter[+].name = "notification-event"
* parameter[=].part[0].name = "event-number"
* parameter[=].part[=].valueString = "1"
* parameter[=].part[+].name = "timestamp"
* parameter[=].part[=].valueInstant = "2020-05-29T11:44:13.1882432-05:00"
* parameter[=].part[+].name = "focus"
* parameter[=].part[=].valueReference = Reference({{cps-base-url}}Task/{{cps-task-01}})