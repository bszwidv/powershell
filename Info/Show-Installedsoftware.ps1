#show-Installedsoftware.ps1
# 
# Shows what Software you have installed using WMI
# Displays product name, version, verndor and installation date
# sorted by product name.
# Author: Thomas Lee
# Tested with PowerShell RC1.1

Function Show-InstalledSoftware {

# get the product details

$prod = Get-WmiObject win32_product

# Now display it nicely

$prod| sort name |ft Name, Version, Vendor, Installdate  -a

}

set-alias sis Show-InstalledSoftware