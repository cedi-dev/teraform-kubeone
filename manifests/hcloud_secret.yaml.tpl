apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: cloud-provider-credentials
  namespace: kube-system
stringData:
  HZ_TOKEN: ${HCLOUD_TOKEN}
