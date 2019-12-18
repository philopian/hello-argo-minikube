#####################################
# MINIKUBE_PROFILE=argo
# DOCKER_IMAGE_NAME=hello-node:v1
# K8S_NAMESPACE=argocd
#####################################

# Apply argo app
pushd argo
kubectl apply -n $K8S_NAMESPACE -f argo.yaml

# Run the local Argo server
kubectl port-forward svc/argocd-server -n $K8S_NAMESPACE 8080:443