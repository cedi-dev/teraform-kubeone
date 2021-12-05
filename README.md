# terraform-kubeone

## first run

if you first use this pipeline, you have to manually run 

```bash
git clone https://github.com/cedi-dev/k8s-manifests.git
helm repo add prometheus https://prometheus-community.github.io/helm-charts
pushd ./k8s-manifests/charts/kube-prometheus-stack/
helm dependency update && helm dependency build
popd
# install prometheus-stack
kubectl create namespace monitoring
helm upgrade --install prometheus-stack ./k8s-manifests/charts/kube-prometheus-stack/ -f ./k8s-manifests/charts/kube-prometheus-stack//values.yaml -n monitoring
```

So the ServiceEndpoint CRD is installed, which is used by the ArgoCD Chart
