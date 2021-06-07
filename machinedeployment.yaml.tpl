apiVersion: v1
kind: Secret
metadata:
  # If you change the namespace/name, you must also
  # adjust the rbac rules
  name: machine-controller-hetzner
  namespace: kube-system
type: Opaque
stringData:
  token: "${HCLOUD_TOKEN}"
---
apiVersion: "cluster.k8s.io/v1alpha1"
kind: MachineDeployment
metadata:
  name: hetzner-machinedeployment
  namespace: kube-system
spec:
  paused: false
  replicas: 1
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  minReadySeconds: 0
  selector:
    matchLabels:
      node: ${CLUSTERNAME}
  template:
    metadata:
      labels:
        node: ${CLUSTERNAME}
    env:
      - name: HZ_TOKEN
        valueFrom:
          secretKeyRef:
            name: machine-controller-hetzner
            key: token
    spec:
      providerSpec:
        value:
          cloudProvider: "hetzner"
          cloudProviderSpec:
            serverType: "cx21"
            location: "fsn1"
            image: "ubuntu-20.04"
            # Optional: network IDs or names
            networks:
              - ${NETWORK_ID}
            # Optional
            labels:
              my: label
          operatingSystem: "ubuntu"
          operatingSystemSpec:
            distUpgradeOnBoot: false
      versions:
        kubelet: ${VERSION}