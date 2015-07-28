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
#	24.07.2014/ap V4.1 - csv handling ASCII (дья...)
#
# preconditions:
# 
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
#	preconditions:
#		home directories and shares have been created
#		privileges have been set
#
#	postconditions:
#		users have been created
#		events have been logged
#
# ---------------------------------------------------
#
# error handling
# ---------------------------------------------------
#Trap [Exception] {
#	"Trapped $($_.Exception.Message)" + ": " + $SAMAccountName | out-file $log  -Append; `
#	continue;
#}
# ---------------------------------------------------
<#
.SYNOPSIS
Create a number of active directory users.

.DESCRIPTION
Create a number of active directory users using a csv-file.

.PARAMETER FirstParameter
Form
start-yes-no

.INPUTS
No objects can be piped to this script. Parameters are entered via dialog.

.OUTPUTS
Logs results of execution.

.EXAMPLE
run: .\create-ADUser.ps1

.LINK
No links to further documentation

.NOTES
No comments at the moment.
#>

$date = get-date
$path = "E:\Admin\ActiveDirectory\"
$forms = $path + "forms\"
$logs = $path + "logs\"
$permission = ':(OI)(CI)M'

# ---------------------------------------------------
$form = read-Host -Prompt "Enter Form: "

$password = Read-Host -AsSecureString "AccountPassword"

$formfolder = "E:\Benutzer\" + $form + "$"

$answer = read-Host -Prompt "Start createADUser (y/n)? "
if($answer -eq "y") {
	write-Host "... about to create users, please standby!"
	$log = $logs + $form + ".log" 
	
	$date | Out-File $log -Append

	 "Start creating users" | out-file $log -Append

# ---------------------------------------------------
$group = Get-ADGroup $form

# TODO handle errors

# process csv-file
# ---------------------------------------------------	

$profilepath = "\\U9dc1\" + $form + "Profiles$\"
$homedirectory = "\\U9dc1\" + $form + "$\"

$file = $forms + $form + ".txt"
	
Get-Content $file -Encoding:String | ConvertFrom-Csv | Foreach-Object {

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
	$user = New-ADUser -SAMAccountName $SAMAccountName `
				-Name $SAMAccountName `
				-GivenName $lastname -Surname $firstname `
				-DisplayName ($lastname + " " + $firstname) `
				-UserPrincipalName ($SAMAccountName + "@bsz.edu") `
				-ProfilePath ($profilepath + $SAMAccountName) `
				-HomeDirectory ($homedirectory + $SAMAccountName) `
				-HomeDrive "H:" `
				-Path ("ou=" + $form + ",ou=BszUsers,dc=bsz,dc=edu") `
				-AccountPassword $password `
				-ChangePasswordAtLogon $true `
				-Enabled $True `
				-PassThru 
				
	add-ADPrincipalGroupMembership $user -memberOf $group
		
	$user.SamAccountName + " has been created" | Out-File $log -Append
	
	new-item -type directory -path "$formfolder\$SAMAccountName\Eigene Dateien"
	& Icacls $formfolder\$SAMAccountName /Grant:r $SAMAccountName$permission
	& Icacls $formfolder\$SAMAccountName /setowner $SAMAccountName /T /C
  }	
}