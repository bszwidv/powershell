# set-IPAddressTo5Range.ps1
# author: CN, modified by ap
# date: 7.8.2014
<#
.SYNOPSIS
Set the IP address to 172.16.5.<random-nn>

.DESCRIPTION
Set the IP address to 172.16.5.<random-nn> in order to have internet access required by activation.

.PARAMETER 
no

.INPUTS
No objects can be piped to this script. Parameters are entered via dialog.

.OUTPUTS
no

.EXAMPLE
run: .\set-IPAddressTo5Range.ps1

.LINK
No links to further documentation

.NOTES
No comments at the moment.
#>


$ConfirmPreference="none"

$randomIP=get-random -maximum 254

# cleanup a previous address
Remove-NetIPAddress -ifalias Ethernet -ipaddress *.*.*.* -PrefixLength 16 -Confirm:$false
Remove-NetRoute -NextHop "172.16.111.1" -Confirm:$false

# create and set IP and DNS
New-NetIPAddress -ifAlias Ethernet -IPAddress 172.16.5.$randomIP -PrefixLength 16 -DefaultGateway 172.16.111.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("172.16.1.1", "172.16.1.2")
#