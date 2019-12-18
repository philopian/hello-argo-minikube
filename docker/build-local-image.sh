# https://nodejs.org/de/docs/guides/nodejs-docker-webapp/

# Local evironement variables
. ../.env
DOCKER_IMAGE_NAME=hello-node:v1

# Point docker to the minikube docker engine instead of local one
eval $(minikube docker-env -p $MINIKUBE_PROFILE)

# Remove image
docker rmi $DOCKER_IMAGE_NAME

# Build the docker image
docker build -t $DOCKER_IMAGE_NAME .

# Check to see if images was created
docker images | grep hello-node