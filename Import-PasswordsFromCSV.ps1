<#
.SYNOPSIS
    Imports passwords for a collection of users from a CSV file
.DESCRIPTION
    
.NOTES
    
.LINK
    
.EXAMPLE
    
#>

param(
    [parameter(Mandatory=$True)] [string]$CsvPath,
    [parameter(Mandatory=$True)] [boolean]$ForceChange
)

Connect-MgGraph -Scopes "User.ReadWrite.All, Directory.ReadWrite.All, Directory.AccessAsUser.All"

$Users = Import-Csv $CSVPath

foreach ($User in $Users) {
# Fetch the user object so that we have access to the user's username, etc.
    $MgUser = Get-MgUser -UserId $User.UserPrincipalName;

	# Build a password profile to apply to the user, including no requirement to change password
    $PasswordProfile = @{
        "Password" = $User.Password
        "ForceChangePasswordNextSignIn" = $ForceChange
    }

    # Reset the password for the user
    Update-MgUser -UserId $MgUser.Id -PasswordProfile $PasswordProfile
}

Disconnect-MgGraph