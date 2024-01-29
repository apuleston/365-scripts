#Requires -Version 3
<#
.SYNOPSIS
  Detects the presence of the personal "Microsoft Teams" client.
.DESCRIPTION
  Detects the presence of the personal "Microsoft Teams" client available at the link below:
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
  Remediate-MicrosoftTeamsHomeClient.ps1
#>

#--------[Script]---------------

try {
    Get-AppxPackage -Name "MicrosoftTeams" | Remove-AppxPackage
}
catch {
    Write-Error "Error removing Microsoft Teams app"
}

if ($null -eq (Get-AppxPackage -Name "MicrosoftTeams")) {
    # Microsoft Teams for home not found
    Write-Output "Microsoft Teams for home successfully removed"
    Exit 0
  } else {
    # Microsoft Teams for home found
    Write-Warning "Error removing Microsoft Teams for home"
    Exit 1
  }