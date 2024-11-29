Instance: hospitalx-patrick
InstanceOf: Patient
Title: "9.01 Patient Patrick Egger"
Description: "Existing data in EHR of Hospital X"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/bsn"
* identifier.value = "111222333"
* name
  * given[0] = "Patrick"
  * family = "Egger"
* telecom[+].system = #phone
* telecom[=].value = "+31612345678"
* telecom[+].system = #email
* telecom[=].value = "patrickegger@myweb.nl"
* gender = #male
* birthDate = "1984-04-01"

Instance: hospitalx-copd
InstanceOf: Condition
Usage: #example
Title: "9.01 Condition COPD"
Description: "Existing data in EHR of Hospital X"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
* meta.versionId = "1"
* meta.lastUpdated = "2024-09-03T12:00:00Z"
* id = "143214345325432"
* code = $sct#13645005 "Chronic obstructive pulmonary disease"
* subject = Reference(urn:uuid:hospitalx-patrick) // Patient Patrick Egger

Instance: hospitalx-heartfailure
InstanceOf: Condition
Usage: #example
Title: "9.01 Condition heartfailure"
Description: "Existing data in EHR of Hospital X"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
* meta.versionId = "1"
* meta.lastUpdated = "2024-09-03T12:00:00Z"
* id = "56476575765"
* code = $sct#84114007 "Hartfalen"
* subject = Reference(urn:uuid:hospitalx-patrick) // Patient Patrick Egger


// Instance: hospitalx-medication-rash
// InstanceOf: Condition
// Usage: #example
// Title: "9.01 Condition medication rash"
// Description: "Existing data in EHR of Hospital X"
// * meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem"
// * category = $sct#116223007 "Complicatie"
// * code = $sct#62014003 "Geneesmiddel-interacties"
// * subject = Reference(hospitalx-patrick) // Patient Patrick Egger
// * subject.type = "Patient"
// * note.text = "Huiduitslag met veel jeuk door medicatie"

Instance: hospitalx-hospitalx
InstanceOf: Organization
Usage: #example
Title: "9.01 Organization Hospital X"
Description: "Existing data in EHR of Hospital X"
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


Instance: hospitalx-msc
InstanceOf: Organization
Usage: #example
Title: "9.01 Organization Medical Service Centre"
Description: "Existing data in EHR of Hospital X"
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

Instance: hospitalx-msc-hcs
InstanceOf: HealthcareService
Usage: #example
Title: "9.01 HealthcareService Telemonitoring at Medical Service Centre"
Description: "Existing data in EHR of Hospital X"
* active = true
* providedBy = Reference(urn:uuid:hospitalx-msc)
* identifier.system = "urn:oid:2.16.840.1.113883.2.4.3.224"
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


Instance: hospitalx-carolinevandijk-hospitalx
InstanceOf: PractitionerRole
Usage: #example
Title: "9.01 PractitionerRole Caroline van Dijk at Hospital X"
Description: "Existing data in EHR of Hospital X"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-PractitionerRole"
* identifier.system = "http://fhir.nl/fhir/NamingSystem/uzi"
* identifier.value = "UZI-1"
* practitioner = Reference(urn:uuid:hospitalx-carolinevandijk)
* organization = Reference(urn:uuid:hospitalx-hospitalx)
* code.coding = $sct#17561000 "Cardiologist"
* specialty.coding = $sct#394579002 "Cardiology"
* telecom[+].system = #email
* telecom[=].value = "c.vandijk@hospitalx.nl"


Instance: hospitalx-carolinevandijk
InstanceOf: Practitioner
Usage: #example
Title: "9.01 Practitioner Caroline van Dijk"
Description: "Existing data in EHR of Hospital X"
* meta.profile = "http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthProfessional-Practitioner"
* name.use = #official
* name.text = "Caroline van Dijk"
* name.family = "van Dijk"
* name.given = "Caroline"
* telecom[+].system = #phone
* telecom[=].value = "+31688888888"
* telecom[+].system = #email
* telecom[=].value = "caroline@vandijk.nl"


Instance: hospitalx-servicerequest-telemonitoring
InstanceOf: ServiceRequest
Usage: #example
Title: "9.01 ServiceRequest Telemonitoring"
Description: "Existing data in EHR of Hospital X"
* meta.versionId = "1"
* meta.lastUpdated = "2024-09-03T12:00:00Z"
* id = "99534756439"
* status = #active
* intent = #order
* subject = Reference(urn:uuid:hospitalx-patrick) "Patient Patrick Egger"
* requester = Reference(urn:uuid:hospitalx-carolinevandijk-hospitalx) "Caroline van Dijk at Hospital X"
* code = $sct#719858009 "monitoren via telegeneeskunde (regime/therapie)"
* reasonReference = Reference(urn:uuid:hospitalx-heartfailure) "Diagnose Hartfalen"
//* orderDetail.text = "COPD Thuismonitoring pakket Light"
//* patientInstruction = "# streefwaarden\n- 30 kg\n- 180 cm\n# aantekeningen\n- Grote hond\n-grote mond\n"



Instance: hospitalx-bundle-01
InstanceOf: Bundle
Usage: #example
Title: "9.01 Bundle"
Description: "Existing data in EHR of Hospital X"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntryWithFullurl(urn:uuid:hospitalx-patrick, hospitalx-patrick, #POST, Patient)
* insert BundleEntryWithFullurl(urn:uuid:hospitalx-copd, hospitalx-copd, #POST, Condition)
* insert BundleEntryWithFullurl(urn:uuid:hospitalx-heartfailure, hospitalx-heartfailure, #POST, Condition)
* insert BundleEntryWithFullurl(urn:uuid:hospitalx-hospitalx, hospitalx-hospitalx, #POST, Organization)
* insert BundleEntryWithFullurl(urn:uuid:hospitalx-msc, hospitalx-msc, #POST, Organization)
* insert BundleEntryWithFullurl(urn:uuid:hospitalx-carolinevandijk-hospitalx, hospitalx-carolinevandijk-hospitalx, #POST, PractitionerRole)
* insert BundleEntryWithFullurl(urn:uuid:hospitalx-carolinevandijk, hospitalx-carolinevandijk, #POST, Practitioner)
* insert BundleEntryWithFullurl(urn:uuid:hospitalx-msc-hcs, hospitalx-msc-hcs, #POST, HealthcareService)
* insert BundleEntryWithFullurl(urn:uuid:hospitalx-servicerequest-telemonitoring, hospitalx-servicerequest-telemonitoring, #POST, ServiceRequest)
