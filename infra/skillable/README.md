# Skillable Lab Deployment Guide

This repository contains Azure infrastructure templates and Skillable Life Cycle Actions (LCAs) for deploying AI Foundry services for a hands-on workshop.

## Overview

The deployment is fully automated through Skillable Life Cycle Actions (LCAs) that handle infrastructure provisioning, configuration, and teardown. The following LCA scripts are executed automatically during the lab lifecycle:

### Life Cycle Actions (LCAs)

1. **LCA-1: Role Assignment** (`lca-1-role-assignment.ps1`)
   - **Timing**: Runs at lab start (15 second delay, blocking)
   - **Purpose**: Assigns necessary Azure roles to the lab user
   - **Actions**:
     - Assigns "Azure AI Developer" role to the resource group
     - Assigns "Cognitive Services User" role to the subscription
     - Uses retry logic to handle transient Azure API failures

2. **LCA-2: Solution Variables** (`lca-2-solution-variables.ps1`)
   - **Timing**: Runs after infrastructure deployment (30 second delay)
   - **Purpose**: Extracts deployment outputs and configures the workshop environment
   - **Actions**:
     - Authenticates to Azure using service principal credentials
     - Retrieves deployment outputs from the ARM/Bicep deployment
     - Creates `.env` file in the lab user's repository with:
       - `PROJECT_ENDPOINT`: Azure AI Foundry project endpoint
       - `AZURE_OPENAI_ENDPOINT`: Azure OpenAI service endpoint
       - `AZURE_OPENAI_KEY`: API key for Azure OpenAI
       - `GPT_MODEL_DEPLOYMENT_NAME`: "gpt-4o"
       - `EMBEDDING_MODEL_DEPLOYMENT_NAME`: "text-embedding-3-small"
       - `APPLICATIONINSIGHTS_CONNECTION_STRING`: Application Insights connection string
       - `AZURE_TRACING_GEN_AI_CONTENT_RECORDING_ENABLED`: "true"
     - Creates `resources.txt` file with Azure resource names for reference
     - Logs all actions to `C:\logs\vm-init_<timestamp>.log`

3. **LCA-5: Disable Windows Update** (`lca-5-disable-windows-update.ps1`)
   - **Timing**: Runs during VM initialization
   - **Purpose**: Prevents Windows updates from interrupting the lab experience
   - **Status**: Currently empty (placeholder for future implementation)

4. **LCA-6: Delete Models** (`lca-6-delete-models.ps1`)
   - **Timing**: Runs during cleanup phase
   - **Purpose**: Removes Azure OpenAI model deployments to free up quota
   - **Actions**:
     - Queries all Cognitive Services accounts in the subscription
     - Retrieves all model deployments from each account
     - Deletes all model deployments
     - Deletes child resources under each account
     - Deletes the Cognitive Services accounts themselves

5. **LCA-7: Tear Down** (`lca-7-tear-down.ps1`)
   - **Timing**: Runs at lab end (20 second delay, blocking, 1 retry)
   - **Purpose**: Completely removes all Azure resources created during the lab
   - **Actions**:
     - Authenticates to Azure using service principal credentials
     - Verifies the resource group exists
     - Deletes the entire resource group and all contained resources
     - Provides status messages during deletion process

## Automated Deployment Process

For Skillable labs, the deployment follows this automated sequence:

1. **Lab Start**: Skillable provisions the Azure subscription and resource group
2. **Infrastructure Deployment**: ARM/Bicep template (`main.json`) is deployed automatically
3. **LCA-1 Execution**: User roles are assigned (15s delay)
4. **LCA-2 Execution**: Environment variables are configured (30s delay)
5. **Lab Ready**: Workshop environment is fully configured and ready to use

## Infrastructure Components

The `main.json` ARM template deploys:

- **AI Foundry Hub & Project**: For AI/ML workloads
- **Model Deployments**: 
  - GPT-4o (for chat and reasoning)
  - text-embedding-3-small (for embeddings)
- **Application Insights**: For monitoring, telemetry, and tracing
- **Storage Account**: For AI Foundry data storage
- **Key Vault**: For secure credential management

## Environment Variables

After successful deployment (automated via LCA-2 or manual), the following environment variables are configured:

| Variable | Description | Example Value |
|----------|-------------|---------------|
| `PROJECT_ENDPOINT` | Azure AI Foundry project API endpoint | `https://<project>.api.azureml.ms/api/projects/<id>` |
| `AZURE_OPENAI_ENDPOINT` | Azure OpenAI service endpoint | `https://<foundry>.openai.azure.com/` |
| `AZURE_OPENAI_KEY` | API key for Azure OpenAI authentication | `<key>` |
| `GPT_MODEL_DEPLOYMENT_NAME` | Name of the GPT model deployment | `gpt-4o` |
| `EMBEDDING_MODEL_DEPLOYMENT_NAME` | Name of the embedding model deployment | `text-embedding-3-small` |
| `APPLICATIONINSIGHTS_CONNECTION_STRING` | Application Insights connection string | `InstrumentationKey=<key>;...` |
| `AZURE_TRACING_GEN_AI_CONTENT_RECORDING_ENABLED` | Enable content tracing for AI operations | `true` |

## Resource Naming Convention

Resources are named using the pattern: `<resource-type>-zava-agent-wks` or with the unique suffix when specified.

For Skillable labs, the resource group is aliased as `rg-ai-toolkit-mcp` and referenced via `@lab.CloudResourceGroup(rg-ai-toolkit-mcp).Name`.

## Lab User Experience

When the lab is provisioned through Skillable:

1. **Automatic Setup**: All Azure resources are deployed and configured automatically
2. **Ready-to-Use Environment**: The `.env` file is pre-configured with all necessary credentials
3. **Reference File**: A `resources.txt` file contains the names of all deployed Azure resources
4. **Logging**: Detailed logs are available at `C:\logs\vm-init_<timestamp>.log`
5. **Clean Exit**: All resources are automatically deleted when the lab ends

## Troubleshooting

### AI Model Quota Issues

If you encounter quota limit errors during deployment, you may need to clean up existing model deployments. The **LCA-6** script automates this cleanup process, but you can also perform it manually:

```powershell
# List all Cognitive Services accounts (including soft-deleted ones)
az cognitiveservices account list --query "[].{Name:name, Location:location, ResourceGroup:resourceGroup, Kind:kind}"

# List model deployments in a specific Cognitive Services account
az cognitiveservices account deployment list --name <cognitive-services-account-name> --resource-group <resource-group-name>

# Delete a specific model deployment
az cognitiveservices account deployment delete --name <deployment-name> --resource-group <resource-group-name> --account-name <cognitive-services-account-name>

# Check current quota usage
az cognitiveservices usage list --location <location> --subscription <subscription-id>
```

### Purging Soft-Deleted AI Models and Accounts

AI models and Cognitive Services accounts are soft-deleted and count against quota even after deletion:

```powershell
# List account names and locations of soft-deleted accounts
az cognitiveservices account list-deleted --query "[].{Name:name, Location:location}" --output table

# Purge a soft-deleted Cognitive Services account (permanently removes it)
az cognitiveservices account purge `
  --location "West US" `
  --resource-group "rg-ai-toolkit-mcp" `
  --name <cognitive-services-account-name>

# Alternative: Use REST API to purge soft-deleted account
az rest --method delete `
  --url "https://management.azure.com/subscriptions/<subscription-id>/providers/Microsoft.CognitiveServices/locations/<location>/resourceGroups/<resource-group>/deletedAccounts/<account-name>?api-version=2021-04-30"
```

**Important Notes:**

- Soft-deleted resources still count against your quota limits
- Purging permanently deletes the resource and cannot be undone
- You may need to wait 48-72 hours after purging before quota is fully released
- If you're still hitting quota limits, consider requesting a quota increase through the Azure portal
- In Skillable labs, **LCA-6** automatically handles deletion of model deployments during cleanup

### Debugging LCA Execution

For Skillable labs, if you encounter issues with the automated setup:

1. **Check LCA Logs**: Review the log file at `C:\logs\vm-init_<timestamp>.log`
2. **Verify Deployment**: Check that the ARM deployment completed successfully in the Azure portal
3. **Check .env File**: Verify that `C:\Users\LabUser\aitour26-WRK542-prototype-agents-with-the-ai-toolkit-and-model-context-protocol\src\.env` exists and contains all required variables
4. **Verify Role Assignments**: Ensure that LCA-1 successfully assigned the necessary roles
5. **Manual Retry**: If an LCA fails, you can manually execute it from PowerShell as an administrator

## Cleanup

### Automated Cleanup (Skillable Labs)

For Skillable labs, cleanup is fully automated and happens in two phases:

1. **LCA-6: Delete Models** - Removes all Azure OpenAI model deployments and Cognitive Services accounts to free up quota
2. **LCA-7: Tear Down** - Deletes the entire resource group and all remaining resources

Both scripts run automatically when the lab ends. No manual intervention is required.

### Manual Cleanup

#### Delete All Resources (Recommended)

To remove all deployed resources at once:

```powershell
# Delete the entire resource group (removes all contained resources)
az group delete --name "rg-ai-toolkit-mcp-$UNIQUE_SUFFIX" --yes --no-wait
```

For Skillable environments without a suffix:

```powershell
az group delete --name "rg-ai-toolkit-mcp" --yes --no-wait
```

#### Delete Individual Resources (If Needed)

If you need to delete specific resources while keeping others:

```powershell
# Delete AI Foundry resources
az ml workspace delete --name <workspace-name> --resource-group "rg-ai-toolkit-mcp"
az cognitiveservices account delete --name <ai-services-name> --resource-group "rg-ai-toolkit-mcp"

# Delete storage account
az storage account delete --name <storage-account-name> --resource-group "rg-ai-toolkit-mcp" --yes

# Delete Application Insights
az monitor app-insights component delete --app <app-insights-name> --resource-group "rg-ai-toolkit-mcp"

# Delete Key Vault (with purge protection)
az keyvault delete --name <keyvault-name> --resource-group "rg-ai-toolkit-mcp"
az keyvault purge --name <keyvault-name> --location "West US"
```

#### Verify Cleanup

```powershell
# Check if resource group is empty
az resource list --resource-group "rg-ai-toolkit-mcp"

# Check for any remaining Cognitive Services (soft-deleted)
az cognitiveservices account list-deleted

# Check for any remaining Key Vaults (soft-deleted)
az keyvault list-deleted
```

**Note**: Some Azure services (like Cognitive Services and Key Vault) have soft-delete protection. Use the purge commands from the Troubleshooting section if you need to permanently remove them.

## Skillable Lab Variables

The following Skillable lab variables are used throughout the LCA scripts:

| Variable | Description | Example |
|----------|-------------|---------|
| `@lab.LabInstance.Id` | Unique lab instance identifier | Used as `$UniqueSuffix` |
| `@lab.CloudSubscription.TenantId` | Azure AD tenant ID | Used for authentication |
| `@lab.CloudSubscription.AppId` | Service principal application ID | Used for authentication |
| `@lab.CloudSubscription.AppSecret` | Service principal secret | Used for authentication |
| `@lab.CloudSubscription.Id` | Azure subscription ID | Target subscription |
| `@lab.CloudResourceGroup(rg-ai-toolkit-mcp).Name` | Resource group name | Target resource group |
| `@lab.CloudPortalCredential(User1).Username` | Lab user's Azure username | Used for role assignments |

## Summary

This Skillable lab deployment provides a fully automated, hands-on workshop experience with:

- **Zero-touch provisioning**: Infrastructure and configuration are handled automatically
- **Pre-configured environment**: All credentials and endpoints are ready to use
- **Clean teardown**: Resources are automatically removed at lab end to prevent quota issues
- **Comprehensive logging**: Detailed logs for troubleshooting and verification
