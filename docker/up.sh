# https://nodejs.org/de/docs/guides/nodejs-docker-webapp/


DOCKER_IMAGE_NAME=hello-node:v1

# Run the docker image locally
docker run --rm -p 3000:3000 $DOCKER_IMAGE_NAME