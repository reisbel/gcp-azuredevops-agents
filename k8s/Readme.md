
# Steps:

Create GKE cluster
https://cloud.google.com/kubernetes-engine/docs/quickstart

Create cluster command on GCP
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

Deploy pod to the cluster
```
kubectl create -f k8s/gke-vsts-agent-ubuntu-1604.yaml
```

# Azure Devops Agents Images:
https://hub.docker.com/r/microsoft/vsts-agent
https://github.com/Microsoft/vsts-agent-docker
