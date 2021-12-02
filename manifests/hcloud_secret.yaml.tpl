---
apiVersion: v1
kind: Namespace
metadata:
  name: external-dns

---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: cloud-provider-credentials
  namespace: external-dns
data:
  HZ_DNS_TOKEN: ${HDNS_TOKEN}

