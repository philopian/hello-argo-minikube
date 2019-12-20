# Load some ENV
. ../.env

# Build the docker image & new k8s manifest
./build.sh


# Apply argo app
pushd ../argo
kubectl apply -n argocd -f argo.yaml
