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
* kind = #requirements
* fhirVersion = #4.0.1
* format = #json
* rest.mode = #server
// CarePlan
* insert SupportResource(CarePlan)
* insert SupportProfile(SCPCareplan)
* insert SupportInteraction(#read)
* insert SupportInteraction(#search-type)
//* insert SupportSearchParam(category, http://example.org/SearchParameter/example-careplan-category, #token, #MAY)
//* insert SupportSearchParam(patient, http://example.org/SearchParameter/example-careplan-patient, #reference, #MAY)
* rest.resource[=].referencePolicy = #resolves



RuleSet: SupportResource (resource)
* rest.resource[+].type = #{resource}
// * rest.resource[=].extension[0].url = $exp
// * rest.resource[=].extension[0].valueCode = {expectation}

RuleSet: SupportProfile (profile)
* rest.resource[=].supportedProfile[+] = "{profile}"
// * rest.resource[=].supportedProfile[=].extension[0].url = $exp
// * rest.resource[=].supportedProfile[=].extension[0].valueCode = {expectation}

RuleSet: SupportInteraction (interaction)
* rest.resource[=].interaction[+].code = {interaction}
// * rest.resource[=].interaction[=].extension[0].url = $exp
// * rest.resource[=].interaction[=].extension[0].valueCode = {expectation}

RuleSet: SupportSearchParam (name, canonical, type)
* rest.resource[=].searchParam[+].name = "{name}"
* rest.resource[=].searchParam[=].definition = "{canonical}"
* rest.resource[=].searchParam[=].type = {type}
// * rest.resource[=].searchParam[=].extension[0].url = $exp
// * rest.resource[=].searchParam[=].extension[0].valueCode = {expectation}