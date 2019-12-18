#####################################
# MINIKUBE_PROFILE=argo
# DOCKER_IMAGE_NAME=hello-node:v1
# K8S_NAMESPACE=argocd
# NAME_PREFIX=dev
#####################################


# Create the local docker image
eval $(minikube docker-env -p $MINIKUBE_PROFILE)
pushd docker
docker rmi $DOCKER_IMAGE_NAME
docker build -t $DOCKER_IMAGE_NAME .
docker images | grep hello-node
popd

# Use kustomize to build the k8s files to ./argo/k8s-app.yaml
pushd k8s
kustomize build example-app/testing | ../argo/example-app/app.yaml
popd


# TODO: 
# TODO: 