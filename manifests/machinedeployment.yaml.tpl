apiVersion: "cluster.k8s.io/v1alpha1"
kind: MachineDeployment
metadata:
  name: "${CLUSTER_NAME}-cx21"
  namespace: "kube-system"
  annotations:
    cluster.k8s.io/cluster-api-autoscaler-node-group-min-size: "1"
    cluster.k8s.io/cluster-api-autoscaler-node-group-max-size: "3"
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
      node: "${CLUSTER_NAME}"
  template:
    metadata:
      labels:
        node: "${CLUSTER_NAME}"
    env:
      - name: HZ_TOKEN
        valueFrom:
          secretKeyRef:
            name: cloud-provider-credentials
            key: HZ_TOKEN
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
              - "${NETWORK_ID}"
          operatingSystem: "ubuntu"
          operatingSystemSpec:
            distUpgradeOnBoot: false
      versions:
        kubelet: "${CLUSTER_VERSION}"
