$path = "E:\Admin\ActiveDirectory\"
$forms = $path + "forms\"
$permission = ':(OI)(CI)M'

$form = read-Host -Prompt "Enter Form: "


$formfolder = "E:\Benutzer\" + $form + "$"

$file = $forms + $form + ".txt"
	import-CSV -Delimiter "," $file | Foreach-Object {
	
		$lastname = $_.Lastname.trim()
		$firstname = $_.Firstname.trim()

		$Loginname = $lastname + $firstname
		if($Loginname.length > 20) {
			$Loginname = $Loginname.Substring(0,20)	
		}
		
		
		new-item -type directory -path $formfolder\$Loginname 
		& Icacls $formfolder\$loginname /Grant:r $Loginname$permission
		& Icacls $formfolder\$loginname /setowner $Loginname /T /C
		
		
}