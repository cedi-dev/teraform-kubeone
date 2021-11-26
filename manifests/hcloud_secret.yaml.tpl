apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: cloud-provider-credentials
  namespace: kube-system
data:
  HZ_TOKEN: ${HCLOUD_TOKEN}
  HZ_DNS_TOKEN: ${HDNS_TOKEN}

