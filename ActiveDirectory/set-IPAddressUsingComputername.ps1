# set-IPAddressUsingComputername.ps1
# author: CN, modified by ap
# date: 7.8.2014
<#
.SYNOPSIS
`tSet the IP address which can be derived using the computername.

.DESCRIPTION
`tSet the IP address which can be derived using the computername. Example:
`t`t172.16.room.host
`t`tU4WKS10 -> 172.16.4.10
`t`t206WKS01 -> 172.16.206.1

.PARAMETER 
`tno

.INPUTS
`tNo objects can be piped to this script. Parameters are entered via dialog.

.OUTPUTS
`tno

.EXAMPLE
`trun: .\set-IPAddressUsingComputername.ps1

.LINK
`tNo links to further documentation

.NOTES
`tNo comments at the moment.
#> 
[CmdletBinding() ]

$ConfirmPreference="none"
$computer = get-content env:computername
$ok = $true

if($computer -like "U??WKS??") { # U10, U11, U12
    write-Verbose "U10/11/12 ist eine Ausnahme"

    [INT]$room = $computer[1]+$computer[2]
    [INT]$host = $computer[6]+$computer[7]

    $newIP = "172.16.$room.$host"
  } elseif($computer.Length -eq 8) { #102 104 112
        write-Verbose "kein U-room"

        [INT]$room = $computer[0]+$computer[1]+$computer[2]
        [INT]$host = $computer[6]+$computer[7]

        $newIP = "172.16.$room.$host"
     } elseif($computer.Length -eq 7) { #U3 U4 oder andere
        write-Verbose "U-room"

        [INT]$room = $computer[1]
        [INT]$host = $computer[5]+$computer[6]
        
        $newIP = "172.16.$room.$host"
    } else {
        write-Error "FEHLER" # TODO specify error
        $ok = $false
    }

if($ok) {
    Remove-NetIPAddress -ifalias Ethernet -ipaddress *.*.*.* -PrefixLength 16 -Confirm:$false
    Remove-NetRoute -NextHop "172.16.111.1" -Confirm:$false

    New-NetIPAddress -ifAlias Ethernet -IPAddress 172.16.$room.$host -PrefixLength 16 -DefaultGateway 172.16.111.1
    Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("172.16.1.1", "172.16.1.2")
}