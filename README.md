# Argo

# Links
- [Getting started](https://argoproj.github.io/argo-cd/getting_started/)
- [kustomize](https://github.com/kubernetes-sigs/kustomize/blob/master/README.md)

## Prerequisite:
  - Minikube & Argo on your local machine
    ```
    $ brew cask install minikube
    $ brew install hyperkit
    $ minikube config set vm-driver hyperkit
    $ brew tap argoproj/tap
    $ brew install argoproj/tap/argocd
    ```





## Run Argo with example K8s app
1. Setup the argo application
  - Setup & run your argo application
    ```
    $ ./start-minikube.sh
    $ ./init-argo.sh
    ```
  - The argo server is now running, now it's time to run your application
    - Open a new Terminal:
      ```
      $ ./apply-argo-app.sh
      ```

2. View your Argo app in the browser
  - Get the admin password
    ```
    $ ./argo/get-argo-password.sh
      argocd-server-xxxxxxxxx-xxxxx
    ```
  - Go to https://localhost:8080/
    username: admin
    password: argocd-server-xxxxxxxxx-xxxxx

## Make shared to the Docker image
1. Change the express server code
2. Bump the package.json file `docker/webserver/package.json`
3. Bump the Docker image version 
  ```
  ./.env
  ./k8s/example-app/base/deployment.yaml
  ```
4. Update the docker/k8s manifest
  ```
  $ cd scripts
  $ ./build.sh
  ```
5. Push code to github to view the changes






## Test out the k8s application without argo
- Make sure you have a cluster ready if not run: `$ ./start-minikube.sh`
- Build the docker image on the cluster's docker engine
  - You want to have this image built before running k8s cause _this specific image_ is _not_ on dockerhub
  ```
  $ cd docker
  $ ./build-local-image.sh
  ```
- Build and run the k8s files
  ```
  $ cd k8s
  $ ./run-local.sh
  ```




## Setup semi-manually
1. Setup your cluster
    ```
    $ minikube start --kubernetes-version v1.15.7 -p argo
    $ eval $(minikube docker-env -p argo)
    $ kubectl config get-contexts
    ```

2. Install Argo CD
    ```
    $ kubectl create namespace argocd
    $ kubectl apply -n argocd -f argo/install.yaml
    ```
  - this will create 2 new resources "CustomResourceDefinition" project & application
    ```
    $ kubectl create clusterrolebinding YOURNAME-cluster-admin-binding --clusterrole=cluster-admin --user=YOUREMAIL@gmail.com
    ```

3. Build local docker image with the k8s docker engine
  - You want to make sure you build the docker image inside the cluster so it will have access to it
    ```
    $ eval $(minikube docker-env -p argo)
    $ cd ./docker
    $ ./build-local-image.sh
    $ docker images
    ```

4. Test your k8s application locally
    ```
    $ cd ./k8s
    $ kubectl create namespace testing-k8s
    $ ./run-local.sh
    $ minikube service test-node-express-api --namespace=testing-k8s -p argo
    $ kubectl delete namespace testing-k8s
    ```

5. Run the Argo CD server locally
  - By default, the Argo CD API server is not exposed with an external IP. 
  - To access the API server, choose one of the following techniques to expose the Argo CD API server:
    (1) ***Port Forwarding***
      - Kubectl port-forwarding can also be used to connect to the API server without exposing the service.
        ```
        $ kubectl port-forward svc/argocd-server -n argocd 8080:443
        ```
      - The API server can then be accessed using the localhost:8080

6. Login Using The CLI
  - The initial password is autogenerated to be the pod name of the Argo CD API server. Get the password with the command:
    $ kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
    argocd-server-xxxxxxxxx-xxxxx
  - go to https://localhost:8080/
    username: admin
    password: argocd-server-xxxxxxxxx-xxxxx


7. Create an Application
  - Get the admin password
    ```
    $ ./argo/get-argo-password.sh
      argocd-server-xxxxxxxxx-xxxxx
    ```
  - Go to https://localhost:8080/
    username: admin
    password: argocd-server-xxxxxxxxx-xxxxx
  - Run an Argo app
    ```
    $ cd argo
    $ kubectl apply -n argocd -f argo.yaml
    ```
  - Access your cluster
    ```
    $ minikube service test-node-express-api --namespace=argocd -p argo
    ```







