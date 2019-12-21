# Load some ENV
. ../.env

# Setup Argo
pushd ../argo
kubectl create namespace argocd
kubectl apply -n argocd -f install.yaml
kubectl create clusterrolebinding YOURNAME-cluster-admin-binding --clusterrole=cluster-admin --user=YOUREMAIL@gmail.com
popd

# Create your k8s application namespace
kubectl create namespace $K8S_NAMESPACE

# Build Docker image on the cluster's docker engine & build the k8s app manifest file
./build.sh

# Run the local Argo server
./start-argo-server.sh
