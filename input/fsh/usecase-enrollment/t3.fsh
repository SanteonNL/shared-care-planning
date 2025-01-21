Instance: cps-task-02
InstanceOf: SCPTask
Usage: #example
Title: "1.22.1 (sub-)Task 2 creation"
Description: "Ask for extra information for telemonitoring"
* meta.versionId = "1"
* contained[0] = msc-telemonitoring-heartfailure-enrollment
* contained[+] = hospitalx-carolinevandijk-hospitalx
* contained[+] = msc-msc
* basedOn = Reference({{org1-fhir-url}}CarePlan/{{careplan1id}})
* partOf = Reference({{org1-fhir-url}}Task/{{task1id}})
* status = #ready
* intent = #order
* code = $task-code#fullfill
* focus = Reference(msc-telemonitoring-heartfailure-enrollment)
* insert RefIdentifier(for, Patient, 1, $bsn, 111222333, $ura, URA-1, org1)
* insert RefIdentifierContained(owner, PractitionerRole, hospitalx-carolinevandijk-hospitalx, $uzi, UZI-1, $ura, URA-1)
* insert RefIdentifierContained(requester, Organization, msc-msc, $ura, URA-2, $ura, URA-2)


Instance: cps-bundle-02
InstanceOf: Bundle
Usage: #example
Title: "1.22.2 Bundle"
Description: "Bundle to ask for extra information for telemonitoring"
* meta.versionId = "1"
* type = #transaction
* insert BundleEntry(cps-task-02, #POST, Task)
//* insert BundleEntryWithFullurl(urn:uuid:msc-telemonitoring-heartfailure-enrollment, msc-telemonitoring-heartfailure-enrollment, #POST, Questionnaire)

Instance: cps-task-signature-02
InstanceOf: Provenance
Usage: #example
// when deploying resources to a HAPIFHIR-server, it automatrically deletes the _history part (version) of the reference
// to prevent this, the extension "auto-version-references-at-path" is used here
* meta.extension.url = "http://hapifhir.io/fhir/StructureDefinition/auto-version-references-at-path"
* meta.extension.valueString = "target"
* target = Reference(Task/{{task2id}}/_history/{{task2etag}})
* recorded = "2024-12-19T15:41:12+01:00"
* reason = $v3-ActReason#TREAT "treatment"
* activity = $v3-DataOperation#CREATE "create"
* agent.type = $provenance-participant-type#author
* insert RefIdentifier(agent.who, Organization, 2, $ura, URA-2, $ura, URA-2, org2)
* signature.type = urn:iso-astm:E1762-95:2013#1.2.840.10065.1.12.1.5 "Verification Signature"
* signature.when = "2024-12-19T15:41:12+01:00"
* insert RefIdentifier(signature.who, Organization, 2, $ura, URA-1, $ura, URA-2, org2)
* signature.targetFormat = #application/fhir+json
* signature.sigFormat = #application/jose
// signature data created using: https://test.webpki.org/jws-ct/create
// FHIR R6 JSON Signature Rules should be applied: https://build.fhir.org/datatypes.html#JSON 
// copy best practices from: https://hl7.org/fhir/us/davinci-cdex/signatures.html#digital-signatures
* signature.data = "c29tZSBzaWduYXR1cmUgZGF0YQ=="