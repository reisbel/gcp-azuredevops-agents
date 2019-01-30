
# Steps:

Create cluster on GCP (https://cloud.google.com/kubernetes-engine/docs/quickstart)
```
gcloud container clusters create [CLUSTER_NAME]
```

Get credentials
```
gcloud container clusters get-credentials devops-agents --zone [CLUSTER_ZONE]
```

Create cluster secrets

```
$ kubectl create secret generic vsts --from-literal=VSTS_TOKEN=[VSTS_TOKEN] --from-literal=VSTS_ACCOUNT=[VSTS_ACCOUNT]
```

Clone repository
```
git clone https://github.com/reisbel/gcp-azuredevops-agents && cd gcp-azuredevops-agents
```

Deploy pod to the cluster
```
kubectl create -f k8s/gke-vsts-agent-ubuntu-1604.yaml
```

Done! Now I we have 4 private agents running on Google Cloud!
![image](https://user-images.githubusercontent.com/247003/52016218-f3d2ca80-24b1-11e9-9518-72d66c0c6223.png)

# Azure Devops Agents Images:
https://hub.docker.com/r/microsoft/vsts-agent

https://github.com/Microsoft/vsts-agent-docker
