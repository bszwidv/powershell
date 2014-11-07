$path = "E:\Temp\" 
$now = get-Date

$raum = read-Host "Raum"
$datei = $raum + ".txt"
$Computers = Get-Content "E:\Temp\Computerräume\$datei"
#
$answer = read-Host -Prompt "Start cleanup (y/n)? "

if($answer -eq "y") 
{
	write-Host "... cleanup running, please standby!"
	foreach ($Computer in $Computers) 
    {
		set-Location -Path ("E:\Benutzer\fpA$\" + $Computer + "\Eigene Dateien") -ErrorAction "SilentlyContinue"
		
		$files = gci -recurse
		foreach($file in $files) 
        {
		    $timespan = new-Timespan -Start $file.LastWriteTime -End $now;	
		    if($timespan.Days -gt 14) 
            {
		    remove-Item $file.FullName -recurse -ErrorAction "SilentlyContinue"
		    }
		}
	 }	
}
else
{
    write-host "Cancelled"
}