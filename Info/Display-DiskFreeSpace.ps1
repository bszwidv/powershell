#Display-DiskFreeSpace.ps1
#Author Thomas Lee tfl@psp.co.uk
#Tested on PowerShell RC1.1

function Display-DiskFreeSpace {
Param ($computer="LocalHost")

#Print nice heading
$name=$(gwo win32_computersystem  -computer $computer).name
"Free space for local hard drives on: $name"

#get the disk perf object

$disk=gwo Win32_PerfRawData_PerfDisk_LogicalDisk -computer $computer

#Iterate and print
 foreach ($d in $disk) {
     $base=$d.percentfreespace_base
     $freespace=$( $d.PercentFreeSpace / $Base)
     $str=$freespace.tostring("P")
     $drivename=$d.name

     If ($drivename -eq "_Total")
       {
        "Total            {0,10} Free" -f $freespace.tostring("P")
       }
     Else
       {
        "Drive {0,5}      {1,10} Free" -f $drivename, $freespace.tostring("P")
       }
  } #end foreach
}

# Create an alias

#new-alias ddfs display-diskfreespace