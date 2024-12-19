Instance: CarePlanContributor-client
InstanceOf: CapabilityStatement
Usage: #definition
Title: "CarePlan Contributor Capability Statement"
Description: "A capability statement for a CarePlan Contributor."
* status = #active
* date = "2024-08-26"
* kind = #requirements
* fhirVersion = #4.0.1
* format = #json
* rest.mode = #client

Instance: CarePlanContributor-server
InstanceOf: CapabilityStatement
Usage: #definition
Title: "CarePlan Contributor Capability Statement"
Description: "A capability statement for a CarePlan Contributor."
* status = #active
* date = "2024-08-26"
* kind = #requirements
* fhirVersion = #4.0.1
* format = #json
* rest.mode = #server

// HealthCareService

// Questionnaire



Instance: CarePlanService-client
InstanceOf: CapabilityStatement
Usage: #definition
Title: "CarePlan Service Capability Statement"
Description: "A capability statement for a CarePlan Service."
* status = #active
* date = "2024-08-26"
* kind = #requirements
* fhirVersion = #4.0.1
* format = #json
* rest.mode = #client

Instance: CarePlanService-server
InstanceOf: CapabilityStatement
Usage: #definition
Title: "CarePlan Service Capability Statement"
Description: "A capability statement for a CarePlan Service."
* status = #active
* date = "2024-08-26"
* implementationGuide = "http://santeonnl.github.io/shared-care-planning"
* kind = #requirements
* fhirVersion = #4.0.1
* format = #json
* rest.mode = #server
* imports[+] = "http://hl7.org/fhir/uv/subscriptions-backport/CapabilityStatement/backport-subscription-server-r4"
// CarePlan
* rest.resource[+].type = #CarePlan
* rest.resource[=].supportedProfile[+] = "SCPCareplan"
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #vread
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].interaction[=].documentation = "clients can't update the activity, subject and author elements. Use Tasks to trigger the server to update the activity, author or subject elements."
// * rest.resource[=].interaction[+].code = #patch
* rest.resource[=].interaction[+].code = #delete
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #history-instance
// * rest.resource[=].interaction[+].code = #history-type
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].readHistory = true
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalRead = #not-supported
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].conditionalDelete = #not-supported
* rest.resource[=].referencePolicy[+] = #literal
* rest.resource[=].referencePolicy[+] = #logical
* rest.resource[=].referencePolicy[+] = #resolves
* rest.resource[=].searchInclude[+] = "CarePlan:subject"
* rest.resource[=].searchInclude[+] = "CarePlan:author"
* rest.resource[=].searchInclude[+] = "CarePlan:activity"
* rest.resource[=].searchInclude[+] = "CarePlan:activity:detail"
* rest.resource[=].searchInclude[+] = "CarePlan:activity:detail:product"
* insert SupportSearchParam(category, #token)

// CareTeam

// Task

// Subscription
* rest.resource[+].type = #Subscription
* rest.resource[=].supportedProfile[+] = "http://hl7.org/fhir/uv/subscriptions-backport/StructureDefinition/backport-subscription"
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].operation[+].name = "status"
* rest.resource[=].operation[=].definition = "http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-status"
* rest.resource[=].operation[+].name = "events"
* rest.resource[=].operation[=].definition = "http://hl7.org/fhir/uv/subscriptions-backport/OperationDefinition/backport-subscription-events"

// QuestionnaireResponse

// Questionnaire

// ServiceRequest

// Condition

// Patient

