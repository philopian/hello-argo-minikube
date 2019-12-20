# Load some ENV
. ../.env

# Apply argo app
pushd argo
kubectl delete -n $K8S_NAMESPACE -f example-app/app.yaml