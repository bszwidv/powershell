#get-dhcpnodetype
# Defines a function to return your NetBios Node type then calls it.
# Author Thomas Lee tfl@psp.co.uk
# Tested with PowerShell RC1.1

function get-dhcpnodetype ()
{
$netbtparamloc = "hklm:\System\CurrentControlSet\Services\netbt\parameters"
$Nodetype    = $(get-itemproperty $netbtparamloc).DHCPNodeType
$nodetypestr="Unknown"
Switch ($Nodetype) 
   {
       4    {$NodeTypeStr = "Mixed"}
       8    {$NodeTypestr = "Hybrid"}
       else {$NodeTypestr = "Not known"}
    }
return $nodetypestr
}

$foo=get-dhcpnodetype
"Your DHCP NetBios node type is: $foo"