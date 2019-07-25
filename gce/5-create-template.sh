
#Create template
gcloud compute instance-templates create  gce-azure-devops-vs2017-server2016 \
    --machine-type n1-standard-2 \
    --image-family azure-devops-vs2017-server2016 \
    --image-project  $PROJECT-ID \
    --metadata-from-file windows-startup-script-ps1=startup.ps1,windows-shutdown-script-ps1=shutdown.ps1