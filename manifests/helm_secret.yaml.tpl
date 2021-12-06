apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: cloud-provider-credentials
  namespace: argocd
data:
  age_private_key: ${AGE_PRIVATE_KEY}
  age_public_key: ${AGE_PUBLIC_KEY}
