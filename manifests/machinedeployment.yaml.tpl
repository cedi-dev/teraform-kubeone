apiVersion: "cluster.k8s.io/v1alpha1"
kind: MachineDeployment
metadata:
  name: "${CLUSTER_NAME}-cpx31"
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
    spec:
      providerSpec:
        value:
          cloudProvider: "hetzner"
          cloudProviderSpec:
            # If empty, can be set via HZ_TOKEN env var
            token:
              secretKeyRef:
                namespace: kube-system
                name: cloud-provider-credentials
                key: HZ_TOKEN
            labels:
              role: worker
              kubeone_cluster_name: "${CLUSTER_NAME}"
            serverType: "cpx31"
            location: "${DATACENTER_LOCATION}"
            image: "ubuntu-20.04"
            networks:
              - "${NETWORK_ID}"
          operatingSystem: "ubuntu"
          operatingSystemSpec:
            distUpgradeOnBoot: false
          sshPublicKeys:
            - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKKQwlVWSGICyOiVryEdEp8bR+ltCxSeikxPTRRgSssL cedi@ivy
            - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC0YM2rlsOXq9OLCMynkPSn6sFkGGOWS9/p5rbcS/OUX cedi@ava
            - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBW7KOtsdmhDszm0qaKdtxExNQqNnl6zJLz1vKRmmod2 cedi@liv
      versions:
        kubelet: "${CLUSTER_VERSION}"
