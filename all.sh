# Load some ENV
. ./.env

# Start Minikube
# minikube start --kubernetes-version v1.15.7 -p $MINIKUBE_PROFILE


# kubectl create namespace $K8S_NAMESPACE
# kubectl apply -n $K8S_NAMESPACE -f argo/install.yaml
# kubectl create clusterrolebinding YOURNAME-cluster-admin-binding --clusterrole=cluster-admin --user=YOUREMAIL@gmail.com
./build.sh
# ./up.sh
# minikube service $NAME_PREFIX-node-express-api --namespace=$K8S_NAMESPACE -p $MINIKUBE_PROFILE