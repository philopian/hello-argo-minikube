# Load some ENV
. ../.env

# Apply argo app
pushd ../argo
kubectl apply -n argocd -f argo.yaml
popd

# Provide a way to access the application in the browser
minikube service node-express-api --namespace=$K8S_NAMESPACE -p $MINIKUBE_PROFILE

echo '\n\n'
echo 'YOUR ARGO PASSWORD:'
kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
echo '\n\n'

sleep 5 # sleep for to allow pods to be created
kubectl port-forward svc/argocd-server -n argocd 8080:443