# modifyHomedir4group.ps1
#
$group = read-Host "Group:"

$users = Get-QADGroupMember $group -Type 'user'

foreach ($user in $users)  {
	#write-Host $user.sAMAccountName
	
	$path = "\\U9Dc1\" + $group + "$\" + $user.sAMAccountName
	#write-Host $path
	set-QADUser $user -HomeDirectory $path -HomeDrive H:
}
