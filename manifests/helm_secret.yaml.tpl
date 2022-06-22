apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: helm-secrets
  namespace: argocd
stringData:
  age_private_key: ${AGE_PRIVATE_KEY}
  age_public_key: ${AGE_PUBLIC_KEY}
