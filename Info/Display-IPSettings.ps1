#IPSettings.ps1
#Author Thomas Lee tfl@psp.co.uk
#Tested on PowerShell RC1.1
#Used Get-WMIObject to return information. 

$Computer = "Lapmin"
$nicConfigs = get-WMIObject Win32_NetworkAdapterConfiguration -Computer $computer | WHERE {$_.IPEnabled}
ForEach ($Nic In $NicConfigs)
{ 
"  Network Adapter $($Nic.Index) - $($Nic.Description)"
"  DHCP Enabled:                    $($Nic.DHCPEnabled)"
 If ($Nic.IPAddress.length -gt 0)
    {$IPAddr=$Nic.IPAddress}
 Else {        $IPAddr = ""}
       "  IP Address(es):                  $IPAddr"  
  If($Nic.IPSubNet.length -gt 0) {$IPsubmet = $Nic.IPSubnet}
     Else {$IPSubnet = ""}
  "  Subnet Mask(s):                  $IPSubnet"
  If   ($Nic.DefaultIPGateway.lengty -gt 0 ) 
  {$DefaultIPGateway=$Nic.DefaultIPGateway}
  Else {$DefaultIPGateway = ""}
  "  Default Gateways(s):              $($Nic.DefaultIPGateway)"
  If   ($NicConfig.GatewayCostMetric.length -gt 0) 
       {$GatewayCostMetric=$NicConfig.GatewayCostMetric}
  Else
      {$GatewayCostMetric = ""}
      "  Gateway Metric(s):                $($Nic.GatewayCostMetric)"
      "  Interface Metric:                $($Nic.IPConnectionMetric)"
      "  Connection-specific DNS Suffix:   $($Nic.DNSDomain)"
""
}