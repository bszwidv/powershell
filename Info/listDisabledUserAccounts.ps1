#List User Account Information
$strComputer = "."

$colItems = get-wmiobject -class "Win32_UserAccount" -namespace "root\CIMV2" -computername $strComputer -Filter "Disabled = True" 

$colItems | Sort-Object @{ e={$_.Caption }; asc=$true } | Format-Table {$_.Caption }


