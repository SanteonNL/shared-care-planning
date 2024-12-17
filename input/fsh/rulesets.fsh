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

RuleSet: SupportSearchParam (name, type)
* rest.resource[=].searchParam[+].name = "{name}"
* rest.resource[=].searchParam[=].type = {type}
// * rest.resource[=].searchParam[=].extension[0].url = $exp
// * rest.resource[=].searchParam[=].extension[0].valueCode = {expectation}

RuleSet: SupportCustomSearchParam (name, canonical, type)
* rest.resource[=].searchParam[+].name = "{name}"
* rest.resource[=].searchParam[=].definition = "{canonical}"
* rest.resource[=].searchParam[=].type = {type}

RuleSet: BundleEntry (resource, method, url)
* entry[+].resource = {resource}
* entry[=].request.method = {method}
* entry[=].request.url = "{url}"

RuleSet: BundleEntryPUT (resource, method, url, etag)
* entry[+].resource = {resource}
* entry[=].request.method = {method}
* entry[=].request.url = "{url}"
* entry[=].request.ifMatch = "W/\"{etag}\""

RuleSet: BundleEntryWithFullurl (fullUrl, resource, method, url)
* entry[+].fullUrl = "{fullUrl}"
* entry[=].resource = {resource}
* entry[=].request.method = {method}
* entry[=].request.url = "{url}"

// RuleSet: ParticipantMember (identifier-system, identifier-value, startdate)
// * participant[+].member.identifier.system = {identifier-system}
// * participant[=].member.identifier.value = "{identifier-value}"
// * participant[=].period.start = "{startdate}"

RuleSet: ParticipantMember (startdate, resource-type, instance-number, identifier-system, identifier-value, assigner-system, assigner-value, source)
* participant[+].period.start = "{startdate}"
* participant[=].member = Reference({{{source}-base-url}}{resource-type}/{{{resource-type}{instance-number}}})
* participant[=].member.type = "{resource-type}"
* participant[=].member.identifier.system = {identifier-system}
* participant[=].member.identifier.value = "{identifier-value}"
* participant[=].member.identifier.assigner.identifier.system = {assigner-system}
* participant[=].member.identifier.assigner.identifier.value = "{assigner-value}"


RuleSet: RefIdentifier (resource-element, resource-type, instance-number, identifier-system, identifier-value, assigner-system, assigner-value, source)
* {resource-element} = Reference({{{source}-base-url}}{resource-type}/{{{resource-type}{instance-number}}})
* {resource-element}.type = "{resource-type}"
* {resource-element}.identifier.system = {identifier-system}
* {resource-element}.identifier.value = "{identifier-value}"
* {resource-element}.identifier.assigner.identifier.system = {assigner-system}
* {resource-element}.identifier.assigner.identifier.value = "{assigner-value}"