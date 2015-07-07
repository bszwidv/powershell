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

$forms = @("Fi2015", "Ik2015", "A2015", "B2015a", "B2015b")

$forms | foreach-Object {
	$form = $_
	$formfolder = "E:\Benutzer\" + $form + "$"

	new-item -type directory -path $formfolder 
		& Icacls $formfolder /Grant:r $form$permission
		& Icacls $formfolder /setowner $form /T /C

	$formfolder = "E:\Benutzer\" + $form + "Profiles$"

	new-item -type directory -path $formfolder
		& Icacls $formfolder /Grant:r $form$permission
		& Icacls $formfolder /setowner $form /T /C
}


