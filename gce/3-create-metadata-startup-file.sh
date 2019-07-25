cat | envsubst '$AZURE_DEVOPS_AGENT_URL $AZURE_DEVOPS_TOKEN $AZURE_DEVOPS_URL' > startup.ps1 << 'EOF'
# Create an installation directory for the Azure Pipelines agent
New-Item -ItemType directory -Path $env:programfiles\vsts-agent

# Create a work directory for the Azure Pipelines agent
New-Item -ItemType directory -Path $env:programdata\vsts-agent

# Download and install the Azure Pipelines agent package
Invoke-WebRequest `
  -Uri "$AZURE_DEVOPS_AGENT_URL" `
  -OutFile $env:TEMP\vsts-agent.zip
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory( `
  "$env:TEMP\vsts-agent.zip", `
  "$env:programfiles\vsts-agent")

# Download and install Packer
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest `
  -Uri "https://releases.hashicorp.com/packer/1.2.2/packer_1.2.2_windows_amd64.zip" `
  -OutFile $env:TEMP\packer.zip
[System.IO.Compression.ZipFile]::ExtractToDirectory( `
  "$env:TEMP\packer.zip", `
  "$env:programfiles\packer")

# Download and install the Cloud SDK
Invoke-WebRequest `
  -Uri https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe `
  -OutFile $env:TEMP\cloudsdk.exe
Start-Process -Wait $env:TEMP\cloudsdk.exe -arg "/S /noreporting /nostartmenu /nodesktop"

# Add Packer and the Cloud SDK installation directory to global path
[Environment]::SetEnvironmentVariable( `
  "Path", $env:Path + ";$env:programfiles\packer;${env:ProgramFiles(x86)}\Google\Cloud SDK\google-cloud-sdk\bin", `
  [System.EnvironmentVariableTarget]::Machine)

# Install gcloud beta commands
$env:CLOUDSDK_PYTHON=gcloud components copy-bundled-python
Start-Process -Wait gcloud -arg "components install beta --quiet"

$FULL_COMPUTER_NAME=[System.Net.Dns]::GetHostName()

# Configure the Azure Pipelines agent
& $env:programfiles\vsts-agent\bin\Agent.Listener configure `
  --url $AZURE_DEVOPS_URL `
  --agent $FULL_COMPUTER_NAME `
  --work $env:programdata\vsts-agent `
  --pool "GCP VS2017" `
  --replace `
  --runAsService `
  --windowsLogonAccount "NT AUTHORITY\NETWORK SERVICE" `
  --auth PAT `
  --token $AZURE_DEVOPS_TOKEN
EOF