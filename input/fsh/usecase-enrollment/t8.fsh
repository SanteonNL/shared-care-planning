Instance: cps-careplan-01-02
InstanceOf: SCPCareplan
Usage: #example
Title: "1.43.1 CarePlan update"
Description: "Add activity (Task) to CarePlan"
* meta.versionId = "2"
* contained[0] = cps-careteam-01-02
* status = #active
* intent = #order
* category = $sct#135411000146103 "Multidisciplinary care regime"
* insert RefIdentifier(subject, Patient, 1, $bsn, 111222333, $ura, URA-1, org1)
* careTeam = Reference(cps-careteam-01-02)
* insert RefIdentifier(author, PractitionerRole, 1, $uzi, UZI-1, $ura, URA-1, org1)
* activity[+].reference = Reference({{org1-fhir-url}}Task/{{task1id}})
* activity[+].reference = Reference({{org2-fhir-url}}Task/{{task2id}})


Instance: cps-careteam-01-02
InstanceOf: CareTeam
Usage: #inline
Title: "1.43.2 CareTeam update"
Description: "Add participant to CareTeam"
* insert ParticipantMember(2024-08-27, Patient, 1, $bsn, 111222333, $ura, URA-1, org1)
* insert ParticipantMember(2024-08-27, PractitionerRole, 1, $uzi, UZI-1, $ura, URA-1, org1)
* insert ParticipantMember(2024-08-27, HealthcareService, 2, $uuid, urn:uuid:91a9be09-eb97-4c0f-9a61-27a1985ae38b, $ura, URA-2, org2)


Instance: cps-bundle-07
InstanceOf: Bundle
Usage: #example
Title: "1.43 Bundle"
Description: "Bundle to update CarePlan and CareTeam"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntry(cps-careplan-01-02, #PUT, CarePlan/{{careplan1id}})


Instance: notification-hospitalx-11
InstanceOf: Bundle
Usage: #example
Title: "1.44 notification bundle for Hospital X"
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-notification-r4"
* type = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry.fullUrl = "urn:uuid:292d3c72-edc1-4d8a-afaa-d85e19c7f5611"
* entry.resource = 292d3c72-edc1-4d8a-afaa-d85e19c7f5611
* entry.request.method = #GET
* entry.request.url = "{{org1-fhir-url}}Subscription/{{subscription1id}}/$status"
* entry.response.status = "200"

Instance: 292d3c72-edc1-4d8a-afaa-d85e19c7f5611
InstanceOf: Parameters
Usage: #inline
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-status-r4"
* parameter[0].name = "subscription"
* parameter[=].valueReference = Reference({{org1-fhir-url}}Subscription/{{subscription1id}})
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
* parameter[=].part[=].valueReference = Reference({{org1-fhir-url}}CarePlan/{{careplan1id}})
* parameter[+].name = "notification-event"
* parameter[=].part[0].name = "event-number"
* parameter[=].part[=].valueString = "5"
* parameter[=].part[+].name = "timestamp"
* parameter[=].part[=].valueInstant = "2024-05-29T11:44:13.1882432-05:01"
* parameter[=].part[+].name = "focus"
* parameter[=].part[=].valueReference = Reference({{org1-fhir-url}}Task/{{task1id}})

Instance: notification-msc-11
InstanceOf: Bundle
Usage: #example
Title: "1.45 notification bundle for MSC"
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-notification-r4"
* type = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry.fullUrl = "urn:uuid:292d3c72-edc1-4d8a-afaa-d85e19c7f5612"
* entry.resource = 292d3c72-edc1-4d8a-afaa-d85e19c7f5612
* entry.request.method = #GET
* entry.request.url = "{{org1-fhir-url}}Subscription/{{subscription2id}}/$status"
* entry.response.status = "200"

Instance: 292d3c72-edc1-4d8a-afaa-d85e19c7f5612
InstanceOf: Parameters
Usage: #inline
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-status-r4"
* parameter[0].name = "subscription"
* parameter[=].valueReference = Reference({{org1-fhir-url}}Subscription/{{subscription2id}})
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
* parameter[=].part[=].valueReference = Reference({{org1-fhir-url}}CarePlan/{{careplan1id}})
* parameter[+].name = "notification-event"
* parameter[=].part[0].name = "event-number"
* parameter[=].part[=].valueString = "5"
* parameter[=].part[+].name = "timestamp"
* parameter[=].part[=].valueInstant = "2024-05-29T11:44:13.1882432-05:01"
* parameter[=].part[+].name = "focus"
* parameter[=].part[=].valueReference = Reference({{org1-fhir-url}}Task/{{task1id}})