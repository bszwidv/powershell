#ipconfig.ps1
#ipconfig for powershell
#author Thomas Lee tfl@psp.co.uk
#tested on PowerShell RC1.1


$tcpipparamloc = "hklm:\System\CurrentControlSet\Services\tcpip\parameters"
$Hostname    = $(get-itemproperty $tcpipparamloc).hostname
$Domainname  = $(get-itemproperty $tcpipparamloc).domain
$Routing     = $(get-itemproperty $tcpipparamloc).IPEnableRouter
$DomainNameD = $(get-itemproperty $tcpipparamloc).UseDomainNameDevolution

$netbtparamloc = "hklm:\System\CurrentControlSet\Services\netbt\parameters"
$Nodetype    = $(get-itemproperty $netbtparamloc).DHCPNodeType
$LMhostsEnab = $(get-itemproperty $netbtparamloc).EnableLMHosts

$nodetypestr="Unknown"
Switch ($Nodetype) {
       4    {$NodeTypeStr = "Mixed"}
       8    {$NodeTypestr = "Hybrid"}
       else {$NodeTypestr = "Not known"}
}

$IPRouting="unknown"
if ($routing -eq 0) {$IPRouting="No"}
if ($routing -eq 1) {$IPRouting="Yes"}

$niccol = gwo Win32_NetworkAdapterConfiguration | WHERE {$_.IPEnabled}

#check if DNS enabled for WINS Resolution anywhere
ForEach ($nic in $NicCol) {$DnsWins = $nic.DNSEnabledForWINSResolution}
If  ($DnsWins)
     {$winsproxy = "Yes"}
Else {$WinsProxy = "No"}

# Display global settings.

"Windows IP Configuration" 
"        Host Name . . . . . . . . . . . . : $Hostname"
"        Primary DNS Suffix  . . . . . . . : $DomainName"
"        Node Type . . . . . . . . . . . . : $NodeTypeStr"
"        IP Routing Enabled. . . . . . . . : $IPRouting"
"        WINS Proxy Enabled. . . . . . . . : $WinsProxy"
"        Use DNS Domain Name Devloution. . : $([boolean]$DomainNameD)"
"        LMHosts Enabled . . . . . . . . . : $([boolean] $LMHostsEnab)"
"        DNS Suffix Search List. . . . . . : $DomainName"
""

# Get os version number = 5.1 is XP.2k3
$OSVersion=[float]$(gwo Win32_OperatingSystem).version.substring(0,3)

# Finally Display per-adapter settings 

$adapterconfigcol = gwo Win32_NetworkAdapterConfiguration 
$adaptercol=        gwo Win32_NetworkAdapter


For ($i=0; $i -lt $adaptercol.length; $i++)
{

  $nic=$adaptercol[$i]
  $config=$adapterconfigcol[$i]
  
# Display Information for IP enabled connections
  If ($config.IPEnabled)
 {  
  
  $Index       = $nic.Index
  $AdapterType = $Nic.AdapterType
  If
   ($OsVersion -gt 5.0)  {$Conn = $Nic.NetConnectionID}
  Else
   {$Conn = $nic.Index}

 "$($Nic.AdapterType) -  Adapter: $Conn"
"Connection-specific DNS Suffix  . : $($config.DNSDomain)"
"Description . . . . . . . . . . . : $($Nic.Description)"
"Physical Address. . . . . . . . . : $($Nic.MACAddress)"
"DHCP Enabled. . . . . . . . . . . : $($Config.DHCPEnabled)"
"Autoconfiguration Enabled . . . . : $($Nic.AutoSense)"
"IP Address. . . . . . . . . . . . : $($config.IPAddress)"
"Subnet Mask . . . . . . . . . . . : $($Config.IPSubnet)"
"Default Gateway . . . . . . . . . : $($Config.DefaultIPGateway)"
"DHCP Server . . . . . . . . . . . : $($Config.DHCPServer)"
"DNS Servers . . . . . . . . . . . : $($Config.DNSServerSearchOrder)"
"Primary WINS Server . . . . . . . : $($Config.WINSPrimaryServer)"
"Secondary WINS Server . . . . . . : $($Config.WINSSecondaryServer)"
"Lease Obtained. . . . . . . . . . : $($Config.DHCPLeaseObtained)"
"Lease Expires . . . . . . . . . . : $($Config.DHCPLeaseExpires)"
 ""
 }
 
 }
