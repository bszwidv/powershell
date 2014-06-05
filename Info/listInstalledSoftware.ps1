# List Installed Software - Microsoft Example adapted by Ap
$strComputer = "Lapmin"
$today = get-Date

$colItems = get-wmiobject -class "Win32_Product" -namespace "root\CIMV2" `
-computername $strComputer


"Installed Software on Lapmin - $today"

$colItems | Sort-Object @{ e={$_.Caption }; asc=$true } | Format-Table {$_.Caption }

#foreach ($objItem in $colItems) {
 #     write-host "Caption: " $objItem.Caption
      #write-host "Description: " $objItem.Description
      #write-host "Identifying Number: " $objItem.IdentifyingNumber
      #write-host "Installation Date: " $objItem.InstallDate
      #write-host "Installation Date 2: " $objItem.InstallDate2
      #write-host "Installation Location: " $objItem.InstallLocation
      #write-host "Installation State: " $objItem.InstallState
      #write-host "Name: " $objItem.Name
      #write-host "Package Cache: " $objItem.PackageCache
      #write-host "SKU Number: " $objItem.SKUNumber
      #write-host "Vendor: " $objItem.Vendor
      #write-host "Version: " $objItem.Version
      #write-host
#}
Read-Host "Weiter mit Taste"
Write-Host "--- END of Report ---"

