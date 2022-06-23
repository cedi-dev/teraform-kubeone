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
              cluster: "${CLUSTER_NAME}"
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
            - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOO9DMiwRjCCWvMA9TKYxRApgQx3g+owxkq9jy1YyjGN cedi@mae
            - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFd4lpqMI7I9fPboMNhGzVrel0cir3D7bHLHADqE1Kmf cedi@devpi
      versions:
        kubelet: "${CLUSTER_VERSION}"
