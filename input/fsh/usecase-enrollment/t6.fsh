Instance: notification-msc-02
InstanceOf: Bundle
Title: "1.27 notification bundle for MSC"
Usage: #example
* meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-notification-r4"
* type = #history
* timestamp = "2020-05-29T11:44:13.1882432-05:00"
* entry.fullUrl = "urn:uuid:292d3c72-edc1-4d8a-afaa-d85e19c7f566"
* entry.resource = 292d3c72-edc1-4d8a-afaa-d85e19c7f566
* entry.request.method = #GET
* entry.request.url = "{{org1-fhir-url}}Subscription/{{subscription2id}}/$status"
* entry.response.status = "200"

Instance: 292d3c72-edc1-4d8a-afaa-d85e19c7f566
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
* parameter[=].part[=].valueString = "2"
* parameter[=].part[+].name = "timestamp"
* parameter[=].part[=].valueInstant = "2020-05-29T11:44:13.1882432-05:05"
* parameter[=].part[+].name = "focus"
* parameter[=].part[=].valueReference = Reference({{org1-fhir-url}}Task/{{task2id}})