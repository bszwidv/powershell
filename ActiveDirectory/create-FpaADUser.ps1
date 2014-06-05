###
#
# Procedure: create AD users using an existing template
# File: createADuser.ps1
#
# Author: ap
#
# Change History:
#	28.08.2011/ap V1
#	29.08.2011/ap V2
#	01.09.2011/ap V3
#	16.09.2011/ap V4
#
# preconditions:
#	template user and his/her group exists, example: Fs2011Template in Fs2011
#	csv-file format example:
#		Lastname,Firstname
#		Friend,Fred
#		Folder,Fanny
#
#	procedure:
#	  import csv-file
#	  while not eof do
#		create ADUser and log result
#		add user to group
#	  end-while
#
#	postconditions:
#		users have been created
#		events have been logged
#
# TODO: create home directories and set privileges
#
#
# params
# ---------------------------------------------------
#
# error handling
# ---------------------------------------------------
#Trap [Exception] {
#	"Trapped $($_.Exception.Message)" + ": " + $SAMAccountName | out-file $log  -Append; `
#	continue;
#}
# ---------------------------------------------------
$date = get-date
$path = "E:\Admin\ActiveDirectory\"
$forms = $path + "forms\"
$logs = $path + "logs\"
$permission = ':(OI)(CI)M'

# ---------------------------------------------------
$form = read-Host -Prompt "Enter Form: "
$formfolder = "E:\Benutzer\" + $form + "$"

$password = Read-Host -AsSecureString "AccountPassword"

$answer = read-Host -Prompt "Start createFpaADUser (y/n)? "
if($answer -eq "y") {
	write-Host "... about to create users, please standby!"
	$log = $logs + $form + ".log" 
	
	$date | Out-File $log -Append

	 "Start creating users" | out-file $log -Append

# get template user and group
# ---------------------------------------------------
	$group = Get-ADGroup $form
#Todo: handle errors
	$sTemplateUser = $form + "Template"
	$templateUser = Get-ADUser -Identity $sTemplateUser

# process csv-file
# ---------------------------------------------------	

#Set User Profile Path
#$profilepath = "\\U9dc1\" + $form + "Profiles$\"
$profilepath = "\\bsz.edu\netlogon\Profiles\fpA"
$homedirectory = "\\U9dc1\" + $form + "$"
#
	$file = $forms + $form + ".txt"
	
	import-CSV -Delimiter "," $file | Foreach-Object {

		Trap [Exception] {
			"Trapped $($_.Exception.Message)" + ": " + $SAMAccountName | out-file $log  -Append; `
			continue;
		}
		$lastname = $_.Lastname.trim()
		$firstname = $_.Firstname.trim()

		$SAMAccountName = $lastname + $firstname
		if($SAMAccountName.length > 20) {
			$SAMAccountName = $SAMAccountName.Substring(0,20)
			"Mind SAMAccountName for $lastname$firstname is $SAMAccountName" | out-file $log -Append
		}
		$user = New-ADUser -SAMAccountName $SAMAccountName -Instance $templateUser `
					-Name $SAMAccountName `
					-GivenName $lastname -Surname $firstname `
					-DisplayName ($lastname + " " + $firstname) `
					-UserPrincipalName ($SAMAccountName + "@bsz.edu") `
					-ProfilePath ($profilepath) `
					-Path ("ou=" + $form + ",ou=BszUsers,dc=bsz,dc=edu") `
					-AccountPassword $password `
					-ChangePasswordAtLogon $true `
					-PassThru 
					
		add-ADPrincipalGroupMembership $user -memberOf $group
		
		$user.SamAccountName + " has been created" | Out-File $log -Append
		
		new-item -type directory -path $formfolder\$SAMAccountName 
		& Icacls $formfolder\$SAMAccountName /Grant:r $SAMAccountName$permission
		& Icacls $formfolder\$SAMAccountName /setowner $SAMAccountName /T /C

	}	
}