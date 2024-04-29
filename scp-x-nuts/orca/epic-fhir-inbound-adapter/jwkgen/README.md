# Epic JWK Generator
Generates JWK sets for JWT signing for Epic API Gateways to communicate with the Epic SMART on FHIR API.

See https://fhir.epic.com/Documentation?docId=oauth2&section=JWKS-URLS

`go run .` generates a new private key and JWK set.

## Media Type
The media type for JWK Sets is `application/jwk-set+json`. To set this in NGINX (not required):

```
# Set media type for JWK sets
location ~* \.jwks$ {
    types {
        application/jwk-set+json jwks;
    }
}
```