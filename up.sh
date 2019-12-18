MINIKUBE_PROFILE=argo
K8S_NAMESPACE=argocd

# Apply argo app
pushd argo
kubectl apply -n $K8S_NAMESPACE -f argo.yaml

# Run the local Argo server
kubectl port-forward svc/argocd-server -n argocd 8080:443