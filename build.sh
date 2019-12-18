# Load some ENV
. ./.env


# Create the local docker image
eval $(minikube docker-env -p $MINIKUBE_PROFILE)
pushd docker
docker rmi $DOCKER_IMAGE_NAME
docker build -t $DOCKER_IMAGE_NAME .
docker images | grep hello-node
popd

# Use kustomize to build the k8s files to ./argo/k8s-app.yaml
pushd k8s/example-app/$K8S_DELOPMENT_ENV
kustomize build . | ../../argo/example-app/app.yaml
popd


# TODO: 
# TODO: 