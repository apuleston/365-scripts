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
  Detect-MicrosoftTeamsHomeClient.ps1
#>

#--------[Script]---------------

if ($null -eq (Get-AppxPackage -Name "MicrosoftTeams")) {
  # Microsoft Teams for home not found
  Write-Output "Microsoft Teams for home not found"
  Exit 0
} else {
  # Microsoft Teams for home found
  Write-Warning "Microsoft Teams for home found"
  Exit 1
}