# Authorization

Shared Care Planning involves authorizations to certain resources. Authorizations are described in an access policy. It is the responsibility of the systems of the Care Plan Contributor and Care Plan Service to adhere to the policy when resources are being requested.

Shared Care Planning involves two different access policies. 
1. The Care Plan Service policy controls access to the resources stored in the Care Plan Service (FHIR-ResourceTypes CarePlan, CareTeam and Task)
2. The Care Plan Contributor policy controls access to resources of which the Care Plan Contributior is Data Holder and controls access to notification service endpoints the Care Plan Contributor exposes.

## Care Plan Service Policy

The Care Plan Service Policy describes access to the resources stored in the Care Plan Service. 

### Access token requirements

When requesting an access token from the authorization server of the Care Plan Service, attributes of both the requesting organization and requesting person MUST be presented (see page Authentication for the exact requirements).

### Resource access
|Resource|CRUDS|Audience/attributes|
|--------|-----|--------|
|CarePlan|C|test|
|Task|C|test|
|CareTeam|C|test|


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
|Resources|RS|test|

### Access to notification service endpoints of the Care Plan Contributior

**Access token requirements**

When requesting an access token from the authorization server of the Care Plan Service for access to notification service endpoints of the Care Plan Contributior, attributes of the requesting organization MUST be presented (see page Authentication for the exact requirements). Attributes of a requesting person MUST NOT be presented.

**Request**

Each notification request MUST include the access token. An abolute reference to the CarePlan-resource that defines the context in which the data request takes place MUST NOT be included.

**Resource access**

|Resource|CRUDS|Audience/attributes/rules|
|--------|-----|--------|
|Incoming notification|C|test|
