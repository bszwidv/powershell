#get-disksize.msh
Param ($Computer = "localhost")
$colDisks = Get-WmiObject Win32_LogicalDisk -computer $computer 
" Device ID    Type               Size(m)     Free Space(m)"
ForEach ($Disk in $colDisks){
 $drivetype=$disk.drivetype
 Switch ($drivetype) {
     2 {$drivetype="FDD"}
     3 {$drivetype="HDD"}
     5 {$drivetype="CD "}
 }

"    {0}         {1}       {2,15:n}  {3,15:n}" -f $Disk.DeviceID, $drivetype, $($disk.Size/1024), $($disk.freespace/1024)
}
""
Read-Host "Weiter mit Taste"
