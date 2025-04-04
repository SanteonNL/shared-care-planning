Instance: msc-hospitalx
InstanceOf: Organization
Usage: #example
Title: "9.02 Organization Hospital X"
Description: "Existing data in EHR of Medical Service Centre"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthcareProvider-Organization"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
* identifier.value = "URA-1"
* name = "Hospital X"
* telecom[0].system = #phone
* telecom[=].value = "+31301234567"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "info@hospitalx.nl"
* telecom[=].use = #work
* address.line = "Koekoekslaan 1"
* address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.line.extension[=].valueString = "Koekoekslaan"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[=].valueString = "1"
* address.city = "Nieuwegein"
* address.postalCode = "3435CM"


Instance: msc-msc
InstanceOf: Organization
Usage: #example
Title: "9.02 Organization Medical Service Centre"
Description: "Existing data in EHR of Medical Service Centre"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthcareProvider-Organization"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/ura"
* identifier.value = "URA-2"
* name = "Medical Service Centre"
* telecom[0].system = #phone
* telecom[=].value = "+31301234567"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "info@msc.nl"
* telecom[=].use = #work
* address.line = "Herculesplein 38"
* address.line.extension[0].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-streetName"
* address.line.extension[=].valueString = "Herculesplein"
* address.line.extension[+].url = "http://hl7.org/fhir/StructureDefinition/iso21090-ADXP-houseNumber"
* address.line.extension[=].valueString = "38"
* address.city = "Utrecht"
* address.postalCode = "3584 AA"


Instance: msc-carolinevandijk-hospitalx
InstanceOf: PractitionerRole
Usage: #example
Title: "9.02 PractitionerRole Caroline van Dijk at Hospital X"
Description: "Existing data in EHR of Medical Service Centre"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-PractitionerRole"
* identifier.system = $uzi
* identifier.value = "UZI-1"
* practitioner = Reference(urn:uuid:msc-carolinevandijk)
* organization = Reference(urn:uuid:msc-hospitalx)
* code.coding = $sct#17561000 "Cardiologist"
* specialty.coding = $sct#394579002 "Cardiology"
* telecom[+].system = #email
* telecom[=].value = "c.vandijk@hospitalx.nl"


Instance: msc-carolinevandijk
InstanceOf: Practitioner
Usage: #example
Title: "9.02 Practitioner Caroline van Dijk"
Description: "Existing data in EHR of Medical Service Centre"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
* name.use = #official
* name.text = "Caroline van Dijk"
* name.family = "van Dijk"
* name.given = "Caroline"
* telecom[+].system = #phone
* telecom[=].value = "+31688888888"
* telecom[+].system = #email
* telecom[=].value = "caroline@vandijk.nl"

Instance: msc-msc-hcs
InstanceOf: HealthcareService
Usage: #example
Title: "9.02 HealthcareService Telemonitoring at Medical Service Centre"
Description: "Existing data in EHR of Medical Service Centre"
* active = true
* providedBy = Reference(urn:uuid:msc-msc)
* identifier.system = $uuid
* identifier.value = "urn:uuid:91a9be09-eb97-4c0f-9a61-27a1985ae38b"
* active = true
* providedBy.identifier.system = $ura
* providedBy.identifier.value = "URA-002"
* category[+] = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* type[+] = $sct#715191006 "monitoren van asthma via telegeneeskunde (regime/therapie)"
* type[+] = $sct#879780004 "monitoren van chronisch hartfalen via telegeneeskunde (regime/therapie)" 
* type[+] = $sct#716358000 "monitoren van chronische obstructieve longziekte via telegeneeskunde (regime/therapie)" 
* type[+] = $sct#84114007 "hartfalen (aandoening)"
* type[+] = $sct#195979001 "Asthma unspecified (disorder)"
* type[+] = $sct#304527002 "acuut astma (aandoening)"
* type[+] = $sct#389145006 "allergisch astma (aandoening)"
* type[+] = $sct#13645005 "chronische obstructieve longaandoening (aandoening)"

Instance: msc-telemonitoring-heartfailure-enrollment
InstanceOf: Questionnaire
Usage: #example
* meta.tag = $FHIR-version#4.0.1
//* contained[0] = YesNo
* language = #nl-NL
* title = "Vragenlijst voor aanmelding van patienten met hartfalen voor telemonitoring"
* url = "http://example.org/Questionnaire-msc-telemonitoring-heartfailure-enrollment|0.3"
* identifier.system = $uuid
* identifier.value = "urn:uuid:95b9cffc-277b-4941-88e0-c0bb6931af01"
* status = #active
* publisher = "Medical Service Centre B.V."
* contact.telecom.system = #url
* contact.telecom.value = "http://example.org"
* experimental = false
* date = "2024-12-11"
* effectivePeriod.start = "2024-12-11"
* useContext[0].code = $usage-context-type#task
* useContext[=].valueCodeableConcept = $v3-ActCode#OE "order entry task"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#84114007 "hartfalen (aandoening)"
* useContext[+].code = $usage-context-type#focus
* useContext[=].valueCodeableConcept = $sct#879780004 "monitoren van chronisch hartfalen via telegeneeskunde (regime/therapie)"
* item[0].linkId = "5c167c2d-f518-4bc1-adb7-ea06bc789a36"
* item[=].text = "Zorgpad"
* item[=].code = $sct#64572001 "aandoening"
* item[=].type = #choice
* item[=].readOnly = true
* item[=].answerOption[0].valueCoding = $sct#84114007 "Hartfalen"
* item[=].answerOption[=].initialSelected = true
* item[+].linkId = "245f3b7e-47d2-4b78-b751-fb04f38b17b9"
* item[=].text = "Selecteer het Meetprotocol"
* item[=].code = $sct#362981000 "kwalificatiewaarde"
* item[=].type = #choice
* item[=].required = true
* item[=].answerOption[0].valueCoding = $sct#255299009 "Instabiel"
* item[=].answerOption[+].valueCoding = $sct#58158008 "Stabiel"

* item[+].linkId = "2f505566-ac92-4347-8731-840e6bc84851" //extra-parameters
* item[=].type = #group
* item[=].enableWhen.question = "245f3b7e-47d2-4b78-b751-fb04f38b17b9"
* item[=].enableWhen.operator = #=
* item[=].enableWhen.answerCoding = $sct#255299009

* item[=].item[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].linkId = "1b81f13b-923e-4fc8-b758-08b3f172b2de"
* item[=].item[=].text = "Titratie"
* item[=].item[=].code = $sct#713838004 "optimaliseren van medicatie"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption.valueCoding = $sct#373066001 "ja, titratie"

// //if you'd want to change previous question to a yes/no radio button:
// * item[=].item[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
// * item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#radio-button
// * item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-choiceOrientation"
// * item[=].item[=].extension[=].valueCode = #horizontal
// * item[=].item[=].linkId = "1b81f13b-923e-4fc8-b758-08b3f172b2de"
// * item[=].item[=].text = "Titratie"
// * item[=].item[=].code = $sct#713838004 "optimaliseren van medicatie"
// * item[=].item[=].type = #choice
// * item[=].item[=].repeats = false
// * item[=].item[=].answerValueSet = "#YesNo"

* item[=].item[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].linkId = "dcba2829-32d8-4390-b1d4-32a5fefda539"
* item[=].item[=].text = "Recompensatie"
* item[=].item[=].code = $sct#308118002 "behandelen van hartfalen"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption.valueCoding = $sct#373066001 "ja, recompensatie"

* item[+].linkId = "170292e5-3163-43b4-88af-affb3e4c27ab"
* item[=].type = #group
* item[=].enableWhen.question = "245f3b7e-47d2-4b78-b751-fb04f38b17b9"
* item[=].enableWhen.operator = #exists
* item[=].enableWhen.answerBoolean = true

* item[=].item[0].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-unit"
* item[=].item[=].extension[=].valueCoding = $unitsofmeasure#kg "kg"
* item[=].item[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].item[=].extension[=].valueString = "Streefgewicht '0.0'"
* item[=].item[=].linkId = "4e973bcb-bbbb-4a9f-877b-fbf45ab94361"
* item[=].item[=].text = "Streefgewicht"
* item[=].item[=].required = true
* item[=].item[=].type = #decimal
* item[=].item[=].code = $sct#1078215008 "Target body weight"

* item[=].item[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].linkId = "135aec2f-e410-4668-9a26-f745dc1789af"
* item[=].item[=].text = "Ziekenhuispatiënt"
* item[=].item[=].code = $sct#266938001 "ziekenhuispatiënt"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption.valueCoding = $sct#373066001 "ja, patiënt is opgenomen geweest"

* item[=].item[+].extension.url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension.valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].linkId = "345ca4a3-1bc8-4358-8d78-783c05953261"
* item[=].item[=].text = "Apparatuur beschikbaar"
* item[=].item[=].code = $sct#735333005 "apparatuur beschikbaar"
* item[=].item[=].type = #choice
* item[=].item[=].required = true
* item[=].item[=].repeats = true
* item[=].item[=].answerOption.valueCoding = $sct#373066001 "ja, patiënt beschikt over een weegschaal en bloeddrukmeter (of is bereid deze aan te schaffen)"

* item[=].item[+].extension.url = "http://hl7.org/fhir/StructureDefinition/entryFormat"
* item[=].item[=].extension.valueString = "Notitie (optioneel)"
* item[=].item[=].linkId = "be4b671d-f91f-4fc3-a6d8-fcafa8e67161"
* item[=].item[=].text = "Notitie"
* item[=].item[=].code = $sct#11221000146107 "notitie (gegevensobject)"
* item[=].item[=].type = #text
* item[=].item[=].repeats = false

* item[+].linkId = "2bc0b73f-506a-48a4-994d-fe355a5825f3"
* item[=].text = "Begeleiding bij onboarding"
* item[=].type = #group
* item[=].enableWhen.question = "245f3b7e-47d2-4b78-b751-fb04f38b17b9"
* item[=].enableWhen.operator = #exists
* item[=].enableWhen.answerBoolean = true

* item[=].item[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].linkId = "295a22d7-d0ff-4546-b2a0-ce46beeba086"
* item[=].item[=].text = "Moeite met apps"
* item[=].item[=].code = $sct#761731000000100 "moeite met gebruiken van personal computer"
* item[=].item[=].type = #choice
* item[=].item[=].repeats = true
* item[=].item[=].answerOption.valueCoding = $sct#373066001 "ja, patiënt heeft hulp nodig bij het downloaden en inloggen in de app"


Instance: msc-bundle-01
InstanceOf: Bundle
Usage: #example
Title: "9.02 Bundle"
Description: "Existing data in EHR of MedicalServiceCentre"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntryWithFullurl(urn:uuid:msc-hospitalx, msc-hospitalx, #POST, Organization)
* insert BundleEntryWithFullurl(urn:uuid:msc-msc, msc-msc, #POST, Organization)
* insert BundleEntryWithFullurl(urn:uuid:msc-carolinevandijk-hospitalx, msc-carolinevandijk-hospitalx, #POST, PractitionerRole)
* insert BundleEntryWithFullurl(urn:uuid:msc-carolinevandijk, msc-carolinevandijk, #POST, Practitioner)
* insert BundleEntryWithFullurl(urn:uuid:msc-msc-hcs, msc-msc-hcs, #POST, HealthcareService)
* insert BundleEntryWithFullurl(urn:uuid:msc-telemonitoring-heartfailure-enrollment, msc-telemonitoring-heartfailure-enrollment, #POST, Questionnaire)
// * insert BundleEntryWithFullurl(urn:uuid:msc-questionnaire-patient-details, msc-questionnaire-patient-details, #POST, Questionnaire)
// * insert BundleEntryWithFullurl(urn:uuid:msc-questionnaire-practitioner-details, msc-questionnaire-practitioner-details, #POST, Questionnaire)

// Instance: msc-questionnaire-patient-details
// InstanceOf: Questionnaire
// Usage: #example
// Title: "9.02 Questionnaire for patient details"
// Description: "Questionnaire for patient details"
// * meta.lastUpdated = "2024-09-02T13:40:17Z"
// * meta.source = "http://decor.nictiz.nl/fhir/4.0/sansa-"
// * meta.tag = $FHIR-version#4.0.1
// * meta.profile[0] = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-pop-exp"
// * meta.profile[+] = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-render"
// * language = #nl-NL
// * url = "http://decor.nictiz.nl/fhir/Questionnaire/2.16.840.1.113883.2.4.3.11.60.909.26.34-2--20240902134017"
// * identifier.system = $uuid
// * identifier.value = "urn:oid:2.16.840.1.113883.2.4.3.11.60.909.26.34-2"
// * name = "patient contactdetails"
// * title = "patient contactdetails"
// * status = #draft
// * experimental = false
// * date = "2024-09-02T13:40:17Z"
// * publisher = "Medical Service Centre"
// * effectivePeriod.start = "2024-09-02T13:40:17Z"
// * extension[0].url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-launchContext"
// * extension[=].extension[0].url = "name"
// * extension[=].extension[=].valueCoding = $launchContext#patient
// * extension[=].extension[+].url = "type"
// * extension[=].extension[=].valueCode = #Patient
// * extension[=].extension[+].url = "description"
// * extension[=].extension[=].valueString = "The patient that is to be used to pre-populate the form"
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2233"
// * item[=].text = "Naamgegevens"
// * item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].text.extension.extension[0].url = "lang"
// * item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].text.extension.extension[+].url = "content"
// * item[=].text.extension.extension[=].valueString = "NameInformation"
// * item[=].type = #group
// * item[=].required = true
// * item[=].repeats = false
// * item[=].readOnly = false
// * item[=].item[0].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2234"
// * item[=].item[=].text = "Voornamen"
// * item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item[=].text.extension.extension[0].url = "lang"
// * item[=].item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].item[=].text.extension.extension[+].url = "content"
// * item[=].item[=].text.extension.extension[=].valueString = "FirstNames"
// * item[=].item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
// * item[=].item[=].extension.valueExpression.language = #text/fhirpath
// * item[=].item[=].extension.valueExpression.expression = "%patient.name.given.first()"
// * item[=].item[=].type = #string
// * item[=].item[=].required = true
// * item[=].item[=].repeats = true
// * item[=].item[=].readOnly = false
// * item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2238"
// * item[=].item[=].text = "Geslachtsnaam"
// * item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item[=].text.extension.extension[0].url = "lang"
// * item[=].item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].item[=].text.extension.extension[+].url = "content"
// * item[=].item[=].text.extension.extension[=].valueString = "LastName"
// * item[=].item[=].type = #group
// * item[=].item[=].required = true
// * item[=].item[=].repeats = true
// * item[=].item[=].readOnly = false
// * item[=].item[=].item[0].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2239"
// * item[=].item[=].item[=].text = "Voorvoegsels"
// * item[=].item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item[=].item[=].text.extension.extension[0].url = "lang"
// * item[=].item[=].item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].item[=].item[=].text.extension.extension[+].url = "content"
// * item[=].item[=].item[=].text.extension.extension[=].valueString = "Prefix"
// * item[=].item[=].item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
// * item[=].item[=].item[=].extension.valueExpression.language = #text/fhirpath
// * item[=].item[=].item[=].extension.valueExpression.expression = "%patient.name.given.last()"
// * item[=].item[=].item[=].type = #string
// * item[=].item[=].item[=].required = false
// * item[=].item[=].item[=].repeats = false
// * item[=].item[=].item[=].readOnly = false
// * item[=].item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2240"
// * item[=].item[=].item[=].text = "Achternaam"
// * item[=].item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item[=].item[=].text.extension.extension[0].url = "lang"
// * item[=].item[=].item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].item[=].item[=].text.extension.extension[+].url = "content"
// * item[=].item[=].item[=].text.extension.extension[=].valueString = "LastName"
// * item[=].item[=].item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
// * item[=].item[=].item[=].extension.valueExpression.language = #text/fhirpath
// * item[=].item[=].item[=].extension.valueExpression.expression = "%patient.name.family"
// * item[=].item[=].item[=].type = #string
// * item[=].item[=].item[=].required = true
// * item[=].item[=].item[=].repeats = false
// * item[=].item[=].item[=].readOnly = false
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2257"
// * item[=].text = "Contactgegevens"
// * item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].text.extension.extension[0].url = "lang"
// * item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].text.extension.extension[+].url = "content"
// * item[=].text.extension.extension[=].valueString = "ContactInformation"
// * item[=].type = #group
// * item[=].required = true
// * item[=].repeats = false
// * item[=].readOnly = false
// * item[=].item[0].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2258"
// * item[=].item[=].text = "Telefoonnummers"
// * item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item[=].text.extension.extension[0].url = "lang"
// * item[=].item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].item[=].text.extension.extension[+].url = "content"
// * item[=].item[=].text.extension.extension[=].valueString = "TelephoneNumbers"
// * item[=].item[=].type = #group
// * item[=].item[=].required = true
// * item[=].item[=].repeats = false
// * item[=].item[=].readOnly = false
// * item[=].item[=].item.linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2259"
// * item[=].item[=].item.text = "Telefoonnummer"
// * item[=].item[=].item.text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item[=].item.text.extension.extension[0].url = "lang"
// * item[=].item[=].item.text.extension.extension[=].valueCode = #en-US
// * item[=].item[=].item.text.extension.extension[+].url = "content"
// * item[=].item[=].item.text.extension.extension[=].valueString = "TelephoneNumber"
// * item[=].item[=].item.extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
// * item[=].item[=].item.extension.valueExpression.language = #text/fhirpath
// * item[=].item[=].item.extension.valueExpression.expression = "%patient.telecom.where(system='phone').value"
// * item[=].item[=].item.type = #string
// * item[=].item[=].item.required = true
// * item[=].item[=].item.repeats = false
// * item[=].item[=].item.readOnly = false
// * item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2263"
// * item[=].item[=].text = "EmailAdressen"
// * item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item[=].text.extension.extension[0].url = "lang"
// * item[=].item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].item[=].text.extension.extension[+].url = "content"
// * item[=].item[=].text.extension.extension[=].valueString = "EmailAddresses"
// * item[=].item[=].type = #group
// * item[=].item[=].required = true
// * item[=].item[=].repeats = false
// * item[=].item[=].readOnly = false
// * item[=].item[=].item.linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2264"
// * item[=].item[=].item.text = "EmailAdres"
// * item[=].item[=].item.text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item[=].item.text.extension.extension[0].url = "lang"
// * item[=].item[=].item.text.extension.extension[=].valueCode = #en-US
// * item[=].item[=].item.text.extension.extension[+].url = "content"
// * item[=].item[=].item.text.extension.extension[=].valueString = "EmailAddress"
// * item[=].item[=].item.extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
// * item[=].item[=].item.extension.valueExpression.language = #text/fhirpath
// * item[=].item[=].item.extension.valueExpression.expression = "%patient.telecom.where(system='email').value"
// * item[=].item[=].item.type = #string
// * item[=].item[=].item.required = true
// * item[=].item[=].item.repeats = false
// * item[=].item[=].item.readOnly = false
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2266"
// * item[=].text = "Burgerservicenummer (OID: 2.16.840.1.113883.2.4.6.3)"
// * item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].text.extension.extension[0].url = "lang"
// * item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].text.extension.extension[+].url = "content"
// * item[=].text.extension.extension[=].valueString = "Burgerservicenummer (OID: 2.16.840.1.113883.2.4.6.3)"
// * item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
// * item[=].extension.valueExpression.language = #text/fhirpath
// * item[=].extension.valueExpression.expression = "%patient.identifier.where(system='http://fhir.nl/fhir/NamingSystem/bsn').value"
// * item[=].type = #string
// * item[=].required = true
// * item[=].repeats = false
// * item[=].readOnly = false
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2267"
// * item[=].text = "Geboortedatum"
// * item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].text.extension.extension[0].url = "lang"
// * item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].text.extension.extension[+].url = "content"
// * item[=].text.extension.extension[=].valueString = "DateOfBirth"
// * item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
// * item[=].extension.valueExpression.language = #text/fhirpath
// * item[=].extension.valueExpression.expression = "%patient.birthDate"
// * item[=].type = #dateTime
// * item[=].required = true
// * item[=].repeats = false
// * item[=].readOnly = false
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2268"
// * item[=].text = "Geslacht"
// * item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].text.extension.extension[0].url = "lang"
// * item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].text.extension.extension[+].url = "content"
// * item[=].text.extension.extension[=].valueString = "Gender"
// * item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
// * item[=].extension.valueExpression.language = #text/fhirpath
// * item[=].extension.valueExpression.expression = "%patient.gender"
// * item[=].type = #choice
// * item[=].required = true
// * item[=].repeats = false
// * item[=].readOnly = false
// // * item[=].answerOption[0].valueCoding = $v3-AdministrativeGender#UN "Undifferentiated"
// // * item[=].answerOption[+].valueCoding = $v3-AdministrativeGender#M "Male"
// // * item[=].answerOption[+].valueCoding = $v3-AdministrativeGender#F "Female"
// // * item[=].answerOption[+].valueCoding = $v3-NullFlavor#UNK "Unknown"
// * item[=].answerOption[0].valueCoding = http://hl7.org/fhir/administrative-gender#other "Other"
// * item[=].answerOption[+].valueCoding = http://hl7.org/fhir/administrative-gender#male "Male"
// * item[=].answerOption[+].valueCoding = http://hl7.org/fhir/administrative-gender#female "Female"
// * item[=].answerOption[+].valueCoding = http://hl7.org/fhir/administrative-gender#unknown "Unknown"



// Instance: msc-questionnaire-practitioner-details
// InstanceOf: Questionnaire
// Usage: #example
// Title: "9.02 Questionnaire for practitioner details"
// Description: "Questionnaire for practitioner details"
// * meta.lastUpdated = "2024-09-02T13:40:17Z"
// * meta.source = "http://decor.nictiz.nl/fhir/4.0/sansa-"
// * meta.tag = $FHIR-version#4.0.1
// * meta.profile[0] = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-pop-exp"
// * meta.profile[+] = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-render"
// * language = #nl-NL
// * url = "http://decor.nictiz.nl/fhir/Questionnaire/2.16.840.1.113883.2.4.3.11.60.909.26.34-3--20240902134017"
// * identifier.system = $uuid
// * identifier.value = "urn:oid:2.16.840.1.113883.2.4.3.11.60.909.26.34-3"
// * name = "practitioner details"
// * title = "practitioner details"
// * status = #draft
// * experimental = false
// * date = "2024-09-02T13:40:17Z"
// * publisher = "Medical Service Centre"
// * effectivePeriod.start = "2024-09-02T13:40:17Z"
// * extension[+].url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-launchContext"
// * extension[=].extension[0].url = "name"
// * extension[=].extension[=].valueCoding = $launchContext#user
// * extension[=].extension[+].url = "type"
// * extension[=].extension[=].valueCode = #Practitioner
// * extension[=].extension[+].url = "description"
// * extension[=].extension[=].valueString = "The practitioner user that is to be used to pre-populate the form"
// * item[0].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2274"
// * item[=].text = "Naamgegevens"
// * item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].text.extension.extension[0].url = "lang"
// * item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].text.extension.extension[+].url = "content"
// * item[=].text.extension.extension[=].valueString = "NameInformation"
// * item[=].type = #group
// * item[=].required = true
// * item[=].repeats = false
// * item[=].readOnly = false
// * item[=].item[0].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2275"
// * item[=].item[=].text = "Voornamen"
// * item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item[=].text.extension.extension[0].url = "lang"
// * item[=].item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].item[=].text.extension.extension[+].url = "content"
// * item[=].item[=].text.extension.extension[=].valueString = "FirstNames"
// * item[=].item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
// * item[=].item[=].extension.valueExpression.language = #text/fhirpath
// * item[=].item[=].extension.valueExpression.expression = "%user.name.given.first()"
// * item[=].item[=].type = #string
// * item[=].item[=].required = true
// * item[=].item[=].repeats = true
// * item[=].item[=].readOnly = false
// * item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2279"
// * item[=].item[=].text = "Geslachtsnaam"
// * item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item[=].text.extension.extension[0].url = "lang"
// * item[=].item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].item[=].text.extension.extension[+].url = "content"
// * item[=].item[=].text.extension.extension[=].valueString = "LastName"
// * item[=].item[=].type = #group
// * item[=].item[=].required = true
// * item[=].item[=].repeats = true
// * item[=].item[=].readOnly = false
// * item[=].item[=].item[0].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2280"
// * item[=].item[=].item[=].text = "Voorvoegsels"
// * item[=].item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item[=].item[=].text.extension.extension[0].url = "lang"
// * item[=].item[=].item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].item[=].item[=].text.extension.extension[+].url = "content"
// * item[=].item[=].item[=].text.extension.extension[=].valueString = "Prefix"
// * item[=].item[=].item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
// * item[=].item[=].item[=].extension.valueExpression.language = #text/fhirpath
// * item[=].item[=].item[=].extension.valueExpression.expression = "%user.name.given.last()"
// * item[=].item[=].item[=].type = #string
// * item[=].item[=].item[=].required = true
// * item[=].item[=].item[=].repeats = false
// * item[=].item[=].item[=].readOnly = false
// * item[=].item[=].item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2281"
// * item[=].item[=].item[=].text = "Achternaam"
// * item[=].item[=].item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item[=].item[=].text.extension.extension[0].url = "lang"
// * item[=].item[=].item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].item[=].item[=].text.extension.extension[+].url = "content"
// * item[=].item[=].item[=].text.extension.extension[=].valueString = "LastName"
// * item[=].item[=].item[=].extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
// * item[=].item[=].item[=].extension.valueExpression.language = #text/fhirpath
// * item[=].item[=].item[=].extension.valueExpression.expression = "%user.name.family"
// * item[=].item[=].item[=].type = #string
// * item[=].item[=].item[=].required = true
// * item[=].item[=].item[=].repeats = false
// * item[=].item[=].item[=].readOnly = false
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2300"
// * item[=].text = "Contactgegevens"
// * item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].text.extension.extension[0].url = "lang"
// * item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].text.extension.extension[+].url = "content"
// * item[=].text.extension.extension[=].valueString = "ContactInformation"
// * item[=].type = #group
// * item[=].required = true
// * item[=].repeats = false
// * item[=].readOnly = false
// * item[=].item.linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2306"
// * item[=].item.text = "EmailAdressen"
// * item[=].item.text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item.text.extension.extension[0].url = "lang"
// * item[=].item.text.extension.extension[=].valueCode = #en-US
// * item[=].item.text.extension.extension[+].url = "content"
// * item[=].item.text.extension.extension[=].valueString = "EmailAddresses"
// * item[=].item.type = #group
// * item[=].item.required = true
// * item[=].item.repeats = false
// * item[=].item.readOnly = false
// * item[=].item.item.linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2307"
// * item[=].item.item.text = "EmailAdres"
// * item[=].item.item.text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item.item.text.extension.extension[0].url = "lang"
// * item[=].item.item.text.extension.extension[=].valueCode = #en-US
// * item[=].item.item.text.extension.extension[+].url = "content"
// * item[=].item.item.text.extension.extension[=].valueString = "EmailAddress"
// * item[=].item.item.extension.url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression"
// * item[=].item.item.extension.valueExpression.language = #text/fhirpath
// * item[=].item.item.extension.valueExpression.expression = "%user.telecom.where(system='email').value"
// * item[=].item.item.type = #string
// * item[=].item.item.required = true
// * item[=].item.item.repeats = false
// * item[=].item.item.readOnly = false
// * item[+].linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2309"
// * item[=].text = "Zorgaanbieder"
// * item[=].text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].text.extension.extension[0].url = "lang"
// * item[=].text.extension.extension[=].valueCode = #en-US
// * item[=].text.extension.extension[+].url = "content"
// * item[=].text.extension.extension[=].valueString = "HealthcareProvider"
// * item[=].type = #group
// * item[=].required = true
// * item[=].repeats = false
// * item[=].readOnly = false
// * item[=].item.linkId = "2.16.840.1.113883.2.4.3.11.60.909.2.2.2310"
// * item[=].item.text = "Zorgaanbieder"
// * item[=].item.text.extension.url = "http://hl7.org/fhir/StructureDefinition/translation"
// * item[=].item.text.extension.extension[0].url = "lang"
// * item[=].item.text.extension.extension[=].valueCode = #en-US
// * item[=].item.text.extension.extension[+].url = "content"
// * item[=].item.text.extension.extension[=].valueString = "HealthcareProvider"
// * item[=].item.type = #group
// * item[=].item.required = true
// * item[=].item.repeats = false
// * item[=].item.readOnly = false

// Instance: msc-actdef-telemon-heartfailure
// InstanceOf: ActivityDefinition
// Usage: #example
// Title: "9.02 ActivityDefinition for telemonitoring heartfailure patients"
// * url = "http://medicalservicecentre.nl/assets/ActivityDefinition/telemon-heartfailure"
// * title = "Telemonitoring for heartfailure patients"
// * description = "Telemonitoring for heartfailure patients"
// * status = #active
// * version = "1.0.0 - initial version"
// * kind = http://hl7.org/fhir/request-resource-types#ServiceRequest
// * intent = #order
// * code = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
// * useContext[+].code = $usage-context-type#focus "Focus"
// * useContext[=].valueCodeableConcept = $sct#195111005 "Heart failure"

// Instance: msc-actdef-telemon-copd
// InstanceOf: ActivityDefinition
// Usage: #example
// Title: "9.02 ActivityDefinition for telemonitoring COPD patients"
// * url = "http://medicalservicecentre.nl/assets/ActivityDefinition/telemon-copd"
// * title = "Telemonitoring for COPD patients"
// * description = "Telemonitoring for COPD patients"
// * status = #active
// * version = "1.0.0 - initial version"
// * kind = http://hl7.org/fhir/request-resource-types#ServiceRequest
// * intent = #order
// * code = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
// * useContext[+].code = $usage-context-type#focus "Focus"
// * useContext[=].valueCodeableConcept = $sct#13645005 "Chronic obstructive pulmonary disease"

