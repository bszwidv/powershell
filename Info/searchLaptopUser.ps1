#Author: Ap
#
# Define search user
$lastName = "Appelmann"
$firstName = "Reinhard"
$computer = "Lapmin"

$search = $computer + "\" + $lastName + $firstName
$provider = "WinNT://"


$colItems = get-wmiobject -class "Win32_UserAccount" -namespace "root\CIMV2"

$colItems | Where {$_.Caption -eq $search }


