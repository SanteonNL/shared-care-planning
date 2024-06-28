# Authorization

Shared Care Planning involves authorizations to certain resources. Authorizations are described in an access policy. It is the responsibility of the systems of the Care Plan Contributor and Care Plan Service to adhere to the policy when resources are being requested.

Shared Care Planning involves two different access policies. 
1. The **Care Plan Service policy** controls access to the resources stored in the Care Plan Service (FHIR-ResourceTypes CarePlan, CareTeam and Task)
2. The **Care Plan Contributor policy** controls access to resources of which the Care Plan Contributior is Data Holder and controls access to notification service endpoints the Care Plan Contributor exposes.

## Care Plan Service Policy

The Care Plan Service Policy describes access to the resources stored in the Care Plan Service. 

### Access token requirements

When requesting an access token from the authorization server of the Care Plan Service, attributes of both the requesting organization and requesting person MUST be presented (see page Authentication for the exact requirements).

### Resource access
|Resource(.element)|CRUDS|Audience/attributes|
|--------|-----|--------|
|CarePlan|C|All healthcare providers with atributes organization-identifier, practitioner-identifier, practitioner-role ?AND having an active service contract with the Care Plan Service?|
|CarePlan|RS|All healthcare providers (active and inactive) in the CareTeam|
|CarePlan.all, .Condition, .Goal, .todo|U|All active healthcare providers in the CareTeam|
|CarePlan.subject, .todo|U|not allowed|
|CarePlan|D|Head Practitioner (equals CarePlan Author)|
|Task|C|All active healthcare providers in the CareTeam|
|Task|RS|All healthcare providers (active en inactive) in the CareTeam, MAYBE: All healthcare providers that are Task.owner can acccess that specific Task (only when notification does not contain enough info)|
|Task|U|All healthcare providers that are Task.requester or Task.owner can access that specific Task|
|CareTeam|RS|All healthcare providers (active and inactive) in the CareTeam |

Operations that are not mentioned in the above table MUST not be supported.

## Care Plan Contributor Policy

The Care Plan Contributor policy describes access to resources of which the Care Plan Contributior is Data Holder (link to EHDS definition?) and describes access to notification service endpoints the Care Plan Contributor exposes.

### Access to resources of which the Care Plan Contributior is Data Holder

**Access token requirements**

When requesting an access token from the authorization server of the Care Plan Service for access to resources of which the Care Plan Contributior is Data Holder, attributes of both the requesting organization and requesting person MUST be presented (see page Authentication for the exact requirements).

**Request**

Each data request MUST include the access token AND an abolute reference to the CarePlan-resource that defines the context in which the data request takes place. The reference to the CarePlan-resource has to be included in HTTP header field...?

**Resource access**

|Resource|CRUDS|Audience/attributes|
|--------|-----|--------|
|Resources*|RS|All active PractitionerRoles in the CareTeam |

*The list of which resources are accessible depends on the context of the CarePlan (Patient, Condition, Request) and possibly the role of the requesting healthcare provider. Condition-Request-Resource lists MUST be specified for each use case that uses Shared Care Planning.

Operations that are not mentioned in the above table MUST not be supported.

### Access to notification service endpoints of the Care Plan Contributior

**Access token requirements**

When requesting an access token from the authorization server of the Care Plan Service for access to notification service endpoints of the Care Plan Contributior, attributes of the requesting organization MUST be presented (see page Authentication for the exact requirements). Attributes of a requesting person MUST NOT be presented.

**Request**

Each notification request MUST include the access token. An abolute reference to the CarePlan-resource that defines the context in which the data request takes place MUST NOT be included.

**Resource access**

|Resource|CRUDS|Audience/attributes/rules|
|--------|-----|--------|
|Incoming notification|C|All (healthcare)organizations that expose a Care Plan Service endpoint|

Operations that are not mentioned in the above table MUST not be supported.

## Use case home monitoring

THIS SHOULD BE MOVED OUTSIDE OF SHARE CARE PLANNING spec in the future.

### Condition-Request-Resource list

|Condition.code|Request.code|Resource|
|--------------|------------|--------|
|COPD/ longaandoeningen|Thuismonitoring|LIJST Condition?code=[alle somatische]|