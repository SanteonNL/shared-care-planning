Instance: cps-task-signature-01
InstanceOf: Provenance
Usage: #example
// when deploying resources to a HAPIFHIR-server, it automatrically deletes the _history part (version) of the reference
// to prevent this, the extension "auto-version-references-at-path" is used here
* meta.extension.url = "http://hapifhir.io/fhir/StructureDefinition/auto-version-references-at-path"
* meta.extension.valueString = "target"
* target = Reference(Task/{{task1id}}/_history/{{task1etag}})
* recorded = "2024-12-19T15:41:12+01:00"
* reason = $v3-ActReason#TREAT "treatment"
* activity = $v3-DataOperation#CREATE "create"
* agent.type = $provenance-participant-type#author
* insert RefIdentifier(agent.who, PractitionerRole, 1, $uzi, UZI-1, $ura, URA-1, org1)
* insert RefIdentifier(agent.onBehalfOf, Organization, 1, $ura, URA-1, $ura, URA-1, org1)
* signature.type = urn:iso-astm:E1762-95:2013#1.2.840.10065.1.12.1.5 "Verification Signature"
* signature.when = "2024-12-19T15:41:12+01:00"
* insert RefIdentifier(signature.who, Organization, 1, $ura, URA-1, $ura, URA-1, org1)
* signature.targetFormat = #application/fhir+json
* signature.sigFormat = #application/jose
// signature data created using: https://test.webpki.org/jws-ct/create
// FHIR R6 JSON Signature Rules should be applied: https://build.fhir.org/datatypes.html#JSON 
// copy best practices from: https://hl7.org/fhir/us/davinci-cdex/signatures.html#digital-signatures
* signature.data = "c29tZSBzaWduYXR1cmUgZGF0YQ=="


Instance: cps-signature-bundle-01
InstanceOf: Bundle
Usage: #example
* type = #transaction
* insert BundleEntry(cps-task-signature-01, #POST, Provenance)