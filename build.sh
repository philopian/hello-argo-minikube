# Load some ENV
. ./.env


# Create the local docker image
eval $(minikube docker-env -p $MINIKUBE_PROFILE)
pushd docker
docker rmi $DOCKER_IMAGE_NAME
docker build -t $DOCKER_IMAGE_NAME .
docker images | grep hello-node
popd


# Create k8s manifest files using kustomize (Results: ./argo/k8s-app.yaml)
pushd k8s/example-app/overlays/$K8S_ENV
kustomize build . > ../../../../argo/example-app/app.yaml
popd
