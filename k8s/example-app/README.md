# Kustomize
- Printout the combined yaml with custom namespaces
  ```
  $ kustomize build example-app/testing
  $ kustomize build example-app/production
  ```

- build and run the k8s config
  ```
  $ kustomize build example-app/production | kubectl apply -f -
  ```