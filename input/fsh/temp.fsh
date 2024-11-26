Alias: $usage-context-type = http://terminology.hl7.org/CodeSystem/usage-context-type




Instance: Tommies-favourite-conceptmap
InstanceOf: ConceptMap
Usage: #definition
* url = "http://hl7.org/fhir/ConceptMap/101"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:53cd62ee-033e-414c-9f58-3ca97b5ffc3b"
* version = "4.0.1"
* name = "FHIR-v3-Address-Use"
* title = "FHIR/v3 Address Use Mapping"
* status = #draft
* experimental = true
* date = "2012-06-13"
* publisher = "HL7, Inc"
* contact.name = "FHIR project team (example)"
* contact.telecom.system = #url
* contact.telecom.value = "http://hl7.org/fhir"
* description = "A mapping between the FHIR and HL7 v3 AddressUse Code systems"
* useContext.code = $usage-context-type#venue
* useContext.valueCodeableConcept.text = "for CCDA Usage"
* jurisdiction = urn:iso:std:iso:3166#US
* purpose = "To help implementers map from HL7 v3/CDA to FHIR"
* copyright = "Creative Commons 0"
* sourceUri = "http://hl7.org/fhir/ValueSet/address-use"
* targetUri = "http://terminology.hl7.org/ValueSet/v3-AddressUse"
* group.source = "http://hl7.org/fhir/address-use"
* group.target = "http://terminology.hl7.org/CodeSystem/v3-AddressUse"
* group.element[0].code = #home
* group.element[=].display = "home"
* group.element[=].target.code = #Huisje
* group.element[=].target.display = "home"
* group.element[=].target.equivalence = #equivalent
* group.element[+].code = #work
* group.element[=].display = "work"
* group.element[=].target.code = #WP
* group.element[=].target.display = "work place"
* group.element[=].target.equivalence = #equivalent
* group.element[+].code = #temp
* group.element[=].display = "temp"
* group.element[=].target.code = #TMP
* group.element[=].target.display = "temporary address"
* group.element[=].target.equivalence = #equivalent
* group.element[+].code = #old
* group.element[=].display = "old"
* group.element[=].target.code = #BAD
* group.element[=].target.display = "bad address"
* group.element[=].target.equivalence = #disjoint
* group.element[=].target.comment = "In the HL7 v3 AD, old is handled by the usablePeriod element, but you have to provide a time, there's no simple equivalent of flagging an address as old"
* group.unmapped.mode = #fixed
* group.unmapped.code = #temp
* group.unmapped.display = "temp"