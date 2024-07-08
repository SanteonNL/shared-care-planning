Shared Care Planning involves authorizations to resources that are part of a) the Shared Care Planning data model, and
b) data that is use case specific. Authorizations are described in an access policy. It is the responsibility of the
systems of the Care Plan Contributor and Care Plan Service to adhere to the policy when resources are being requested in
the context of Shared Care Planning.

Shared Care Planning involves two different access policies.

1. The **Care Plan Service policy** controls access to the resources stored in the Care Plan Service (FHIR-ResourceTypes
   CarePlan, CareTeam and Task) and are part of the Shared Care Planning data model.
2. The **Care Plan Contributor policy** controls access to resources of which the Care Plan Contributor is Data Holder
   and controls access to notification service endpoints the Care Plan Contributor exposes. The data controlled by the
   Care Plan Contributor can both be part of the Shared Care Planning data model or use case specific data.

### Care Plan Service Policy

The Care Plan Service Policy describes access to the resources stored in the Care Plan Service.

### Audiences

* All healthcare providers in the `CareTeam.participant`.
    * Active, the `CareTeam.participant.period` of the memberships falls within the current time.
    * Inactive, the `CareTeam.participant.period` of the memberships falls outside the current time
* Head Practitioner, the `CarePlan.author`
* All healthcare providers that are `Task.requester` or `Task.owner`

#### Access token requirements

When requesting an access token from the authorization server of the Care Plan Service, attributes of both the
requesting organization and requesting person MUST be presented (see page Authentication for the exact requirements).
_Note that for all transactions an active user session is required and the use MUST be identifiable, either direct by
user interaction or indirect by cryptographic proof, by all involved parties._

#### Resource access

<table>
<thead>
<tr>
<th>Resource(.element)</th>
<th>CRUDS</th>
<th>Audience/attributes</th>
</tr>
</thead>
<tbody>
<tr>
<td>CarePlan</td>
<td>C</td>
<td>All healthcare providers with atributes organization-identifier, practitioner-identifier, practitioner-role ?AND having an active service contract with the Care Plan Service?</td>
</tr>
<tr>
<td>CarePlan</td>
<td>RS</td>
<td>All healthcare providers (active and inactive) in the CareTeam</td>
</tr>
<tr>
<td>CarePlan.all, .Condition, .Goal, .todo</td>
<td>U</td>
<td>All active healthcare providers in the CareTeam</td>
</tr>
<tr>
<td>CarePlan.subject, .todo</td>
<td>U</td>
<td>not allowed</td>
</tr>
<tr>
<td>CarePlan</td>
<td>D</td>
<td>Head Practitioner (equals CarePlan Author)</td>
</tr>
<tr>
<td>Task</td>
<td>C</td>
<td>All active healthcare providers in the CareTeam</td>
</tr>
<tr>
<td>Task</td>
<td>RS</td>
<td>All healthcare providers (active en inactive) in the CareTeam, MAYBE: All healthcare providers that are Task.owner can access that specific Task (only when notification does not contain enough info)</td>
</tr>
<tr>
<td>Task</td>
<td>U</td>
<td>All healthcare providers that are Task.requester or Task.owner can access that specific Task</td>
</tr>
<tr>
<td>CareTeam</td>
<td>RS</td>
<td>All healthcare providers (active and inactive) in the CareTeam</td>
</tr>
</tbody>
</table>


Operations that are not mentioned in the above table MUST not be supported.

### Care Plan Contributor Policy

The Care Plan Contributor policy describes access to resources of which the Care Plan Contributor
is [Data Holder](https://www.european-health-data-space.com/European_Health_Data_Space_Article_2_(Proposal_3.5.2022).html)
and describes access to notification service endpoints the Care Plan Contributor exposes.

#### Access to resources of which the Care Plan Contributor is Data Holder

**Access token requirements**

When requesting an access token from the authorization server of the Care Plan Service for access to resources of which
the Care Plan Contributor is Data Holder, verifiable attestations of both the requesting organization and requesting
person MUST be presented (see page Authentication for the exact requirements). The credentials MUST proof the
attestation of the following attributes:

* Organization
* PractitionerRole

**Request**

Each data request MUST include the access token AND an absolute reference to the CarePlan-resource that defines the
context in which the data request takes place. The reference to the CarePlan-resource has to be included in HTTP header
field as follows:

```http request
GET /Condition HTTP/1.1
X-SCP-Context: https://careplan-service.example.com/fhir/CarePlan/73012d35
Authorization: Bearer 03c90ce0-fe7b-44fb-aff7-b09ef4e45863
```

**Resource access**

| Resource   | CRUDS | Audience/attributes                          |
|------------|-------|----------------------------------------------|
| Resources* | RS    | All active PractitionerRoles in the CareTeam |

*The list of which resources are accessible depends on the context of the CarePlan (Patient, Condition, Request) and
possibly the role of the requesting healthcare provider. Condition-Request-Resource lists MUST be specified for each use
case that uses Shared Care Planning.

Operations that are not mentioned in the above table MUST not be supported.

#### Access to notification service endpoints of the Care Plan Contributor

**Access token requirements**

When requesting an access token from the authorization server of the Care Plan Service for access to notification
service endpoints of the Care Plan Contributor, attributes of the requesting organization MUST be presented (see page
Authentication for the exact requirements). Attributes of a requesting person MUST NOT be presented.

**Request**

Each notification request MUST include the access token. An abolute reference to the CarePlan-resource that defines the
context in which the data request takes place MUST NOT be included.

**Resource access**

| Resource              | CRUDS | Audience/attributes/rules                                              |
|-----------------------|-------|------------------------------------------------------------------------|
| Incoming notification | C     | All (healthcare)organizations that expose a Care Plan Service endpoint |
| *                     | RUDS  | Not allowed                                                            |

Operations that are not mentioned in the above table MUST not be supported.

#### Access to use case specific care data

The Care Plan Contributor shares use case specific data with the other Care Plan Contributor(s) or Care Plan User(s)
within the use case. This data is read-only by nature. Access rules are not so much defined on resource type level,
instead, they are defined in resource instance level, where resources relative to the CarePlan and related entities are
*filtered* within the scope of the request. The `X-SCP-Context` header provided the context of the request. The Data
Holder SHOULD use the following content to apply the access rules:

* CarePlan and its related data
* The proof of the organization's identity.
* The proof of the user's identity.

#### An example of use case specific access rules.

The access and filtering rules COULD be articulated in a tabular format that make use of specific data related to this
context, for example:

* `CarePlan.subject` The `patient` related to the resource.
* `CarePlan.addresses[Condition].code` The `type of condition`, like *COPD*.
* `CarePlan.activity[ServiceRequest].code` The `type of service`, like *Home monitoring*.
* Resource, the resource type.

An example rules for home monitoring could look like the following:

| Condition.code                                              | Request.code                      | Resource                                                    |
|-------------------------------------------------------------|-----------------------------------|-------------------------------------------------------------|
| *                                                           | *                                 | Patient?id=patient.id                                       |
| 13645005 (Chronic obstructive pulmonary disease (disorder)) | 719858009 (Telehealth monitoring) | Condition?subject=patient&category=[all somatic conditions] |
| *                                                           | 719858009 (Telehealth monitoring  | CarePlan?id=CarePlan.id                                     |
| *                                                           | 719858009 (Telehealth monitoring  | CareTeam?subject=patient.id                                 |

### Notes / Questions

* The careteam is supposed to have Active / Inactive members, is that managed by Period?
