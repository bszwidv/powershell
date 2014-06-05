#Get-NetworkAdapterSettings.ps1
#Gets Information about network adapters in your system
#Author Thomas Lee tfl@psp.co.uk
#Tested with PowerShell RC1.1


Param ($computer = "localhost")

$NetAdapters = gwo Win32_NetworkAdapter -computer $computer
"Network Adapter Settings"
ForEach ($Nic In $NetAdapters)
{
"Network Adapter (Device ID) $($nic.DeviceID)"
"  Index:                 $($Nic.Index)"
"  MAC Address:           $($nic.MACAddress)"
"  Adapter Type:          $($nic.AdapterType)"
"  Adapter Type Id:       $($nic.AdapterTypeID)"
"  Description:           $($nic.Description)"
"  Manufacturer:          $($nic.Manufacturer)"
"  Name:                  $($nic.Name)"
"  Product Name:          $($Nic.ProductName)"
"  Net Connection ID:     $($nic.NetConnectionID)"
"  Net Connection Status: $($nic.NetConnectionStatus)"
"  PNP Device ID:         $($nic.PNPDeviceID)"
"  Service Name:          $($nic.ServiceName)" 
   If ($Nic.NetworkAddresses.length -gt 0) 
      {$add= $Nic.NetworkAddresses}
   Else
      {$add = ""}
"  NetworkAddresses:      $add"
"  Permanent Address:     $($nic.PermanentAddress)"
"  AutoSense:             $($nic.AutoSense)"
"  Max Controlled:        $($nic.MaxNumberControlled)"
"  Speed:                 $($nic.Speed)"
"  Maximum Speed:         $($nic.MaxSpeed)"
""
}