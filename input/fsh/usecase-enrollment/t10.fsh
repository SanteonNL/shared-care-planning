// Instance: notification-msc-03
// InstanceOf: Bundle
// Title: "1.49 notification bundle for MSC"
// Usage: #example
// * meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-notification-r4"
// * type = #history
// * timestamp = "2020-05-29T11:44:13.1882432-05:00"
// * entry.fullUrl = "urn:uuid:292d3c72-edc1-4d8a-afaa-d85e19c7f5610"
// * entry.resource = 292d3c72-edc1-4d8a-afaa-d85e19c7f5610
// * entry.request.method = #GET
// * entry.request.url = "https://cps.nl/fhir/Subscription/cps-sub-medicalservicecentre/$status"
// * entry.response.status = "200"

// Instance: 292d3c72-edc1-4d8a-afaa-d85e19c7f5610
// InstanceOf: Parameters
// Usage: #inline
// * meta.profile = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription-status-r4"
// * parameter[0].name = "subscription"
// * parameter[=].valueReference = Reference(cps-sub-medicalservicecentre)
// * parameter[+].name = "status"
// * parameter[=].valueCode = #active
// * parameter[+].name = "type"
// * parameter[=].valueCode = #event-notification
// * parameter[+].name = "notification-event"
// * parameter[=].part[0].name = "event-number"
// * parameter[=].part[=].valueString = "2"
// * parameter[=].part[+].name = "timestamp"
// * parameter[=].part[=].valueInstant = "2020-05-29T11:44:13.1882432-05:05"
// * parameter[=].part[+].name = "focus"
// * parameter[=].part[=].valueReference = Reference(cps-task-03-02)