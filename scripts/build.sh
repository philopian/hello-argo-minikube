# Load some ENV
. ../.env


# Create the local docker image
eval $(minikube docker-env -p $MINIKUBE_PROFILE)
pushd ../docker
docker rmi $DOCKER_IMAGE_NAME
docker build -t $DOCKER_IMAGE_NAME .
docker images | grep hello-node
popd


# Create k8s manifest files using kustomize (Results: ./argo/k8s-app.yaml)
pushd ../k8s/example-app/overlays/$K8S_NAMESPACE
kustomize build . > ../../../../argo/example-app/app.yaml
popd


# TODO: update the argo.yaml file to point to the proper namespace
pushd ../argo
cat > argo.yaml <<EOF
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: example-argo-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: $GITHUB_REPO
    targetRevision: HEAD
    path: argo/example-app
    directory:
      recurse: true
  destination:
    server: https://kubernetes.default.svc
    namespace: $K8S_NAMESPACE
  syncPolicy:
    automated:
      prune: false
      selfHeal: false
EOF
popd