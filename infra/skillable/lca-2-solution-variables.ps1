# LCA Metadata
# Delay: 30 seconds

# =========================
# VM Life Cycle Action (PowerShell)
# Pull outputs from ARM/Bicep deployment and write .env
# =========================

# --- logging ---
$logDir = "C:\logs"
if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir | Out-Null }
$logFile = Join-Path $logDir "vm-init_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
"[$(Get-Date -Format s)] VM LCA start" | Tee-Object -FilePath $logFile

function Log { param([string]$m) $ts = "[$(Get-Date -Format s)] $m"; $ts | Tee-Object -FilePath $logFile -Append }

# --- Skillable tokens / lab values ---
$UniqueSuffix = "@lab.LabInstance.Id"
$TenantId = "@lab.CloudSubscription.TenantId"
$AppId = "@lab.CloudSubscription.AppId"
$Secret = "@lab.CloudSubscription.AppSecret"
$SubId = "@lab.CloudSubscription.Id"

# Resource group and target path
$ResourceGroup = "rg-ai-toolkit-mcp"
$targetPath = "C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\src"

# --- Azure login ---
Log "Authenticating to Azure tenant $TenantId, subscription $SubId"
$sec = ConvertTo-SecureString $Secret -AsPlainText -Force
$cred = [pscredential]::new($AppId, $sec)
Connect-AzAccount -ServicePrincipal -Tenant $TenantId -Credential $cred -Subscription $SubId | Out-Null
$ctx = Get-AzContext
Log "Logged in as: $($ctx.Account) | Sub: $($ctx.Subscription.Name)"

# --- Find deployment and read OUTPUTS ---
Log "Searching RG-scope deployments in $ResourceGroup"
$deployment = Get-AzResourceGroupDeployment -ResourceGroupName $ResourceGroup | Sort-Object Timestamp -Descending | Select-Object -First 1

if (-not $deployment) {
    throw "Could not locate any ARM/Bicep deployments to read outputs from."
}

Log "Using deployment: $($deployment.DeploymentName)"
$outs = $deployment.Outputs

# Extract values
$projectsEndpoint = $outs.projectsEndpoint.value
$applicationInsightsConnectionString = $outs.applicationInsightsConnectionString.value
$aiFoundryName = $outs.aiFoundryName.value

if (-not $projectsEndpoint) { throw "Deployment output 'projectsEndpoint' not found." }
if (-not $applicationInsightsConnectionString) { throw "Deployment output 'applicationInsightsConnectionString' not found." }
if (-not $aiFoundryName) { throw "Deployment output 'aiFoundryName' not found." }

Log "projectsEndpoint = $projectsEndpoint"
Log "applicationInsightsConnectionString captured."
Log "aiFoundryName = $aiFoundryName"

# Derive Azure OpenAI endpoint
$azureOpenAIEndpoint = $projectsEndpoint -replace 'api/projects/.*$', ''
Log "Derived AZURE_OPENAI_ENDPOINT = $azureOpenAIEndpoint"

# Get Azure OpenAI key
Log "Retrieving Azure OpenAI key for $aiFoundryName"
$keys = Get-AzCognitiveServicesAccountKey -ResourceGroupName $ResourceGroup -Name $aiFoundryName
$azureOpenAIKey = $keys.Key1
Log "Azure OpenAI key retrieved."

# --- Static workshop values ---
$GPT_MODEL_DEPLOYMENT_NAME = "gpt-4o"
$EMBEDDING_MODEL_DEPLOYMENT_NAME = "text-embedding-3-small"

# --- Write .env file ---
$ENV_FILE_PATH = Join-Path $targetPath ".env"
if (Test-Path $ENV_FILE_PATH) { Remove-Item -Path $ENV_FILE_PATH -Force }

@"
PROJECT_ENDPOINT="$projectsEndpoint"
AZURE_OPENAI_ENDPOINT="$azureOpenAIEndpoint"
AZURE_OPENAI_KEY="$azureOpenAIKey"
GPT_MODEL_DEPLOYMENT_NAME="$GPT_MODEL_DEPLOYMENT_NAME"
EMBEDDING_MODEL_DEPLOYMENT_NAME="$EMBEDDING_MODEL_DEPLOYMENT_NAME"
APPLICATIONINSIGHTS_CONNECTION_STRING="$applicationInsightsConnectionString"
AZURE_TRACING_GEN_AI_CONTENT_RECORDING_ENABLED="true"
"@ | Set-Content -Path $ENV_FILE_PATH -Encoding UTF8

Log "Created .env at $ENV_FILE_PATH"

# --- Write resources.txt ---
$aiProjectName = if ($outs.aiProjectName) { $outs.aiProjectName.value } else { $null }
$applicationInsightsName = if ($outs.applicationInsightsName) { $outs.applicationInsightsName.value } else { $null }

$RESOURCES_FILE_PATH = Join-Path $targetPath "resources.txt"
if (Test-Path $RESOURCES_FILE_PATH) { Remove-Item -Path $RESOURCES_FILE_PATH -Force }

@(
    "Azure AI Foundry Resources:",
    "- Resource Group Name: $ResourceGroup",
    "- AI Project Name: $aiProjectName",
    "- Foundry Resource Name: $aiFoundryName",
    "- Application Insights Name: $applicationInsightsName"
) | Out-File -FilePath $RESOURCES_FILE_PATH -Encoding utf8

Log "Created resources.txt at $RESOURCES_FILE_PATH"
Log "VM LCA complete."