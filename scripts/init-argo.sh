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
sleep 2 # sleep for to allow pods to be created
kubectl port-forward svc/argocd-server -n argocd 8080:443
