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

RuleSet: ParticipantMember (resource, resource-display, startdate)
* participant[+].member = Reference({resource})
* participant[=].member.display = "{resource-display}"
* participant[=].period.start = "{startdate}"