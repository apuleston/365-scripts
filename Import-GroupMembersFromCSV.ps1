<#
.SYNOPSIS
    Imports a list of users from a CSV file and adds them to a group in Entra ID.
.DESCRIPTION
    Imports a list of users from a CSV file and adds them to a group in Entra ID. The CSV file should contain one column:
    - UserPrincipalName
    Any additional columns will be ignored
.NOTES
    
.LINK
    
.EXAMPLE
    PS> Import-GroupMembersFromCSV.ps1 -CsvPath "path-to-csv-file.csv" -GroupName "GroupName"
    Import the group members from CSV and add them to the group "GroupName".
#>

param(
    [parameter(Mandatory=$True)] [string]$CsvPath,
    [parameter(Mandatory=$True)] [string]$GroupName
)

Connect-MgGraph -Scopes "User.Read.All, Group.ReadWrite.All"

$Users = Import-Csv $CSVPath
$Group = Get-MgGroup -Filter ("DisplayName eq '" + $GroupName + "'")

foreach ($User in $Users) {
    # Fetch the user object so that we have access to the user's username, etc.
    $MgUser = Get-MgUser -UserId $User.UserPrincipalName

    # Add the user to the group.
	New-MgGroupMember -GroupId $Group.Id -DirectoryObjectId $MgUser.Id
}

Disconnect-MgGraph