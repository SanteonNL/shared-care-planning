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

RuleSet: BundleEntry (resource, method, url)
* entry[+].resource = {resource}
* entry[=].request.method = {method}
* entry[=].request.url = "{url}"

RuleSet: BundleEntryWithFullurl (fullUrl, resource, method, url)
* entry[+].fullUrl = "{fullUrl}"
* entry[=].resource = {resource}
* entry[=].request.method = {method}
* entry[=].request.url = "{url}"

RuleSet: ParticipantMember (identifier-system, identifier-value, startdate)
* participant[+].member.identifier.system = "{identifier-system}"
* participant[=].member.identifier.value = "{identifier-value}"
* participant[=].period.start = "{startdate}"