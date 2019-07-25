cat | envsubst '$AZURE_DEVOPS_AGENT_URL $AZURE_DEVOPS_TOKEN $AZURE_DEVOPS_URL' > shutdown.ps1 << 'EOF'
$FULL_COMPUTER_NAME=[System.Net.Dns]::GetHostName()

# Configure the Azure Pipelines agent
& $env:programfiles\vsts-agent\bin\Agent.Listener remove `
  --unattended `
  --auth PAT `
  --token $AZURE_DEVOPS_TOKEN
  
EOF