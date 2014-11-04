$path = "E:\Temp\" 
$now = get-Date

$raum = read-Host "Raum: "
$Computers = Get-Content "E:\Temp\Computerr�ume.txt"
#	
$answer = read-Host -Prompt "Start cleanup (y/n)? "

if($answer -eq "y") {
	write-Host "... cleanup running, please standby!"

	foreach ($Computer in $Computers) {
		set-Location -Path ("E:\Benutzer\fpA$\" + $Computer + "\Eigene Dateien") -ErrorAction "SilentlyContinue"
		
		$files = gci -recurse
		foreach($file in $files) {
			$timespan = new-Timespan -Start $file.LastWriteTime -End $now;	
			if($timespan.Days -gt 14) {
				remove-Item $file.FullName -recurse -ErrorAction "SilentlyContinue"
			}
		}
	}
	set-Location E:\Admin\Powershell
}