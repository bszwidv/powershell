$forms = @("Fi2016", "Ik2016", "A2016", "B2016a", "B2016b")

$forms | foreach-Object {
	$form = $_
	$formfolder = "E:\Benutzer\" + $form
	
	$answer = (Get-WmiObject Win32_Share -List).create($formfolder, $form + "$", 0)
#	TODO log answer
#	TODO configure share permissions
	
	$formfolder = "E:\Benutzer\" + $form + "Profiles"

	$answer = (Get-WmiObject Win32_Share -List).create($formfolder, $form + "$", 0)
#	TODO log answer
#	TODO configure share permissions
		
}
#$myshare = Get-WmiObject -Class Win32_Share -ComputerName NOTEMIN -Filter "Name='Backup'"
#$myshare | Get-Acl | Format-List *

#$permission = "jeder","FullControl","Allow"
#$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
#$acl.SetAccessRule($accessRule)
#$acl | Set-Acl F:\Backup