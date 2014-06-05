# createSoftwareInventary.ps1
#
$Path = "D:\Temp\"
$manufacturer = "*Microsoft*"
$inFile = $Path + "computers.txt"
$outFile = $Path + "SoftwareInventary.cvs"

$computers = Get-Content $inFile
$computers | foreach-object -process {
  if  (Ping($_)) {
      Write-Host "get software for computer $_ ..."
	  $software = foreach-object -process {
      
	    Get-WmiObject -Class Win32_product -computername $_
	  } | where {
            $_.Vendor -like $manufacturer
		  }
		  $software | export-Csv $outFile -NoTypeInformation
  } else {
      Write-Error "Computer $_ nicht erreichbar"
  }
}

function Ping {
  $state = Get-WmiObject Win32_Pingstatus -filter "Address='args[0]'" |
             Select-Object Statuscode
  return $state.Statuscode -eq 0
}
	
		