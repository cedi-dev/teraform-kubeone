---
apiVersion: v1
kind: Namespace
metadata:
  name: fip-controller

---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: cloud-provider-credentials
  namespace: fip-controller
data:
  HCLOUD_API_TOKEN: ${HCLOUD_TOKEN}
