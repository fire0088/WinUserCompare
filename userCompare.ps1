#Usage: powershell .\userCompare.ps1 -User1 myUser1 -User2 myUser2
#Gets the AD group permissions for 2 users and outputs the unique values for each.

param(
  [Parameter(Mandatory=$true)]
  [string]$User1,
  [Parameter(Mandatory=$true)]
  [string]$User2
)

# Get the Active Directory groups for the two users
$user1Groups = Get-ADUser -Identity $User1 -Properties memberof | Select -ExpandProperty memberof | Sort-Object
$user2Groups = Get-ADUser -Identity $User2 -Properties memberof | Select -ExpandProperty memberof | Sort-Object

# Compare the two groups and output the unique values
Write-Host "Unique groups for user ${User1}:" 
foreach($group in $user1Groups) {
	if( $user2Groups -notcontains $group) {
		
		Write-Host $group	
	
	}
}
Write-Host "`n`n"
Write-Host "Unique groups for user ${User2}:" 
foreach($group in $user2Groups) {
	if( $user1Groups -notcontains $group) {
		
		Write-Host $group	
	
	}
}

