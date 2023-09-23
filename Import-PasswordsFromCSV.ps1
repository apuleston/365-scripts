<#
.SYNOPSIS
    Imports passwords for a collection of users from a CSV file
.DESCRIPTION
    Imports passwords for a collection of users from a CSV file. The CSV file should contain two columns:
    - UserPrincipalName
    - Password
    Any additional columns will be ignored
.NOTES
    
.LINK
    
.EXAMPLE
    PS> Import-PasswordsFromCSV.ps1 -CsvPath "path-to-csv-file.csv" -ForceChange $True
    Import the passwords and require the user to change their password at next sign in.

.EXAMPLE
    PS> Import-PasswordsFromCSV.ps1 -CsvPath "path-to-csv-file.csv" -ForceChange $False
    Import the passwords and *do not* require the user to change their password at next sign in.
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