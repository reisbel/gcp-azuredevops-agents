docker run \
  -e VSTS_ACCOUNT=[VSTS_ACCOUNT]]\
  -e VSTS_TOKEN=[VSTS_TOKEN] \
  -e VSTS_AGENT='$(hostname)-agent' \
  -e VSTS_POOL=GCP \
  -e VSTS_WORK='/var/vsts/$VSTS_AGENT' \
  -v /var/vsts:/var/vsts \
  -it microsoft/vsts-agent:ubuntu-16.04