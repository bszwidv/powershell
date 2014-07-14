# createSoftwareInventary.ps1
# created by Ap
# modified:
#	14.7.2014

<#
.SYNOPSIS
Create an inventory of installed software.

.DESCRIPTION
Create an inventory of installed microsoft software on one or more boxes.
Reads the file .\Computers.txt to get the computer names.

Precondition: file D:\Temp\Computers.txt exists

.PARAMETER FirstParameter
No parameters required.

.INPUTS
No objects can be piped to this script.

.OUTPUTS
Outputs result to SoftwareInventory.csv.

.EXAMPLE
run: crSoftwareInventory.ps1

.LINK
No links to further documentation

.NOTES
Use a WMIObject to get the required information. Test connection to see if system is alive.
#>

$Path = "D:\Temp\"
$log = "D:\Temp\Logs\"
$logfile = $log + "crSoftwareInventory.log"
$manufacturer = "*Microsoft*"
$inFile = $Path + "Computers.txt"
$outFile = $Path + "SoftwareInventory.csv"

$computers = Get-Content $inFile
	$computers | foreach-object -process {
	  if  (Test-Connection $_ -Quiet) {
		  Write-Verbose "about to get software for computer $_ ..."
		  $software = foreach-object -process {
			Get-WmiObject -Class Win32_product -computername $_
		  } | where {
				$_.Vendor -like $manufacturer
			  }
			  $software | export-Csv $outFile -NoTypeInformation
	  } else {
		  "Computer $_ nicht erreichbar"  | out-File -FilePath $logfile -encoding ASCII -append 
	    }
	}