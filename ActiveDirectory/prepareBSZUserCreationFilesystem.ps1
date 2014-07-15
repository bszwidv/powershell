# prepareBSZUserCreationFilesystem
# created by ap 14.7.2014
# modified:

<#
.SYNOPSIS
Create file system objects for coming term.

.DESCRIPTION
Create file system objects, i.e. HomeDir and ProfileDir for each form respectively.

.PARAMETER FirstParameter
No parameters required.

.INPUTS
No objects can be piped to this script.

.OUTPUTS
No outputs at the moment. Should log results.

.EXAMPLE
run: prepareBSZUserCreationFilesystem.ps1

.LINK
No links to further documentation

.NOTES
No comments at the moment.
#>

$permission = ':(OI)(CI)M'
$forms = @("Fi2014", "Ik2014", "A2014", "K2014a", "K2014b")

$forms | foreach-Object {
	$form = $_
	$formfolder = "E:\Benutzer\" + $form + "$"

	new-item -type directory -path $formfolder 
		& Icacls $formfolder /Grant:r $form$permission
		& Icacls $formfolder /setowner $form /T /C

	#new-PSDrive -PSProvider FileSystem -Name ... or use WMI
	$answer = (Get-WmiObject Win32_Share -List).create($formfolder, $formfolder, 0)
#	TODO log answer
#	TODO configure share permissions
	
	$formfolder = "E:\Benutzer\" + $form + "Profiles$"

	new-item -type directory -path $formfolder
		& Icacls $formfolder /Grant:r $form$permission
		& Icacls $formfolder /setowner $form /T /C

	$answer = (Get-WmiObject Win32_Share -List).create($formfolder, $formfolder, 0)
#	TODO log answer
#	TODO configure share permissions
		
}


#$myshare = Get-WmiObject -Class Win32_Share -ComputerName NOTEMIN -Filter "Name='Backup'"
#$myshare | Get-Acl | Format-List *

#$permission = "jeder","FullControl","Allow"
#$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
#$acl.SetAccessRule($accessRule)
#$acl | Set-Acl F:\Backup