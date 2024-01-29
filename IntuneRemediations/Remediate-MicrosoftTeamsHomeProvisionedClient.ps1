#Requires -Version 3
<#
.SYNOPSIS
  Detects the provisioning of the personal "Microsoft Teams" client.
.DESCRIPTION
  Detects the provisioning of the personal "Microsoft Teams" client available at the link below:
  https://www.microsoft.com/en-gb/microsoft-teams/teams-for-home
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        1
  Author:         Austen Puleston
  Creation Date:  29th Jan 2024
  Purpose/Change: Initial script development
  
.EXAMPLE
  Remediate-MicrosoftTeamsHomeProvisionedClient.ps1
#>

#--------[Script]---------------

try {
    Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like "MicrosoftTeams"} | Remove-AppxProvisionedPackage
}
catch {
    Write-Error "Error deprovisioning Microsoft Teams app"
}

if ($null -eq (Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like "MicrosoftTeams"})) {
    # Microsoft Teams for home not provisioned
    Write-Output "Microsoft Teams for home successfully deprovisioned"
    Exit 0
  } else {
    # Microsoft Teams for home provisioned
    Write-Warning "Error deprovisioning Microsoft Teams for home"
    Exit 1
  }