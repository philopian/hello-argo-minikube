# Load some ENV
. ../.env

# Provide a way to access the application in the browser
minikube service node-express-api --namespace=$K8S_NAMESPACE -p $MINIKUBE_PROFILE