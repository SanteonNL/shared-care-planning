package smart_on_fhir

import (
	"encoding/json"
	"fmt"
	"github.com/google/uuid"
	"github.com/lestrrat-go/jwx/v2/jwk"
	"github.com/lestrrat-go/jwx/v2/jwt"
	"golang.org/x/oauth2"
	"io"
	"log"
	"net/http"
	"net/url"
	"time"
)

// grantTokenValidity specifies how long the grant token (used to acquire the access token) is valid.
const grantTokenValidity = time.Minute

var _ oauth2.TokenSource = &BackendTokenSource{}

type BackendTokenSource struct {
	OAuth2ASTokenEndpoint string
	ClientID              string
	SigningKey            jwk.Key
}

func (p BackendTokenSource) Token() (*oauth2.Token, error) {
	log.Println("Refreshing OAuth2 Access Token")
	grantJWT, err := p.createGrant()
	if err != nil {
		return nil, fmt.Errorf("failed to create JWT grant: %w", err)
	}
	token, err := p.exchange(grantJWT)
	if err != nil {
		return nil, fmt.Errorf("failed to retrieve token: %w", err)
	}
	return token, nil
}

func (p BackendTokenSource) exchange(grantJWT string) (*oauth2.Token, error) {
	// Loosely inspired by golang.org/x/oauth2@v0.19.0/jwt/jwt.go
	// Specified by https://fhir.epic.com/Documentation?docId=oauth2&section=Backend-Oauth2_Getting-Access-Token
	v := url.Values{}
	v.Set("grant_type", "client_credentials")
	v.Set("client_assertion_type", "urn:ietf:params:oauth:client-assertion-type:jwt-bearer")
	v.Set("client_assertion", grantJWT)
	response, err := http.PostForm(p.OAuth2ASTokenEndpoint, v)
	if err != nil {
		return nil, fmt.Errorf("cannot fetch token: %v", err)
	}
	defer response.Body.Close()
	body, err := io.ReadAll(io.LimitReader(response.Body, 1024*1024)) // 1mb
	if err != nil {
		return nil, fmt.Errorf("cannot fetch token: %v", err)
	}
	if c := response.StatusCode; c < 200 || c > 299 {
		return nil, &oauth2.RetrieveError{
			Response: response,
			Body:     body,
		}
	}
	var result oauth2.Token
	if err := json.Unmarshal(body, &result); err != nil {
		return nil, fmt.Errorf("cannot unmarshal token response: %w", err)
	}
	return &result, nil
}

func (p BackendTokenSource) createGrant() (string, error) {
	// Create JWT according to https://fhir.epic.com/Documentation?docId=oauth2&section=Creating-JWTs
	claims := map[string]interface{}{
		jwt.IssuerKey:     p.ClientID,
		jwt.SubjectKey:    p.ClientID,
		jwt.AudienceKey:   p.OAuth2ASTokenEndpoint,
		jwt.JwtIDKey:      uuid.NewString(),
		jwt.ExpirationKey: time.Now().Add(grantTokenValidity),
		jwt.IssuedAtKey:   time.Now(),
		jwt.NotBeforeKey:  time.Now(),
	}
	tokenBuilder := jwt.New()
	for claimName, claimValue := range claims {
		if err := tokenBuilder.Set(claimName, claimValue); err != nil {
			return "", fmt.Errorf("invalid JWT claim %s: %w", claimName, err)
		}
	}
	signedToken, err := jwt.Sign(tokenBuilder, jwt.WithKey(p.SigningKey.Algorithm(), p.SigningKey))
	if err != nil {
		return "", fmt.Errorf("failed to sign JWT: %w", err)
	}
	return string(signedToken), nil
}
