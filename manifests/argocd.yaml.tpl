---
apiVersion: v1
kind: Namespace
metadata:
  name: argocd

---
apiVersion: v1
kind: Secret
metadata:
  name: github-secret
  namespace: argocd
type: Opaque
data:
  github.oauth.clientID: ${GITHUB_OIDC_CLIENT_ID}
  github.oauth.clientSecret: ${GITHUB_OIDC_CLIENT_SECRET}
