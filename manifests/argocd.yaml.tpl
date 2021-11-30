---
apiVersion: v1
kind: Namespace
metadata:
  name: argocd

---
apiVersion: v1
kind: Secret
metadata:
  name: argocd-secret
  namespace: argocd
type: Opaque
data:
  dex.oauth.clientID: ${GITHUB_OIDC_CLIENT_ID}
  dex.oauth.clientSecret: ${GITHUB_OIDC_CLIENT_SECRET}
