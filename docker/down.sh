
DOCKER_IMAGE=hello-node:v1
DEPLOYMENT_NAME=hello-nodejs


kubectl delete deployment $DEPLOYMENT_NAME
kubectl delete service $DEPLOYMENT_NAME