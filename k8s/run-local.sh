# Local evironement variables
. ../.env
K8S_NAMESPACE=testing
K8S_DELOPMENT_ENV=testing
NAME_PREFIX=test

# Point docker to the minikube docker engine instead of local one
eval $(minikube docker-env -p $MINIKUBE_PROFILE)

# Create the namespace 
kubectl create namespace $K8S_NAMESPACE

# Run the config
kustomize build example-app/$K8S_DELOPMENT_ENV | kubectl apply -f -


# Run the service in the browser
minikube service $NAME_PREFIX-node-express-api --namespace=$K8S_NAMESPACE -p $MINIKUBE_PROFILE