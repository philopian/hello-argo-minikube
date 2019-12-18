# https://nodejs.org/de/docs/guides/nodejs-docker-webapp/

DOCKER_IMAGE_NAME=hello-node:v1

# Remove image
docker rmi $DOCKER_IMAGE_NAME

# Build the docker image
docker build -t $DOCKER_IMAGE_NAME .

# Check to see if images was created
docker images | grep hello-node