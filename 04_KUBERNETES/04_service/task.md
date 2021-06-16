# Recreate Python+Redis on Kubernetes

1. Create Deployment yaml file for redis 
2. Create Deployment yaml file for krajewskim/python-api:redis
3. Set LOG_LEVEL env to DEBUG on python deployment
4. Set REDIS_HOST env to name of redis service
5. Make sure all ports are correct
6. Use proper labels
7. Create service yaml file for redis without NodePort type
8.  Create service yaml file for python with NodePort type
9.  Create everything at once with:

```sh
kubectl create -f .
```

# check everything works 

```sh
kubectl exec -ti $(kubectl get pods -l app=myapp -o jsonpath='{.items[0].metadata.name}') -- curl python-service:5002/api/v1/info
kubectl exec -ti $(kubectl get pods -l app=myapp -o jsonpath='{.items[0].metadata.name}') -- /bin/bash -c "curl -XPOST python-service:5002/api/v1/info"
kubectl exec -ti $(kubectl get pods -l app=myapp -o jsonpath='{.items[0].metadata.name}') -- curl python-service:5002/api/v1/info
```
