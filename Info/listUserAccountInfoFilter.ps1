#List User Account Information
$strComputer = "."

$colItems = get-wmiobject -class "Win32_UserAccount" -namespace "root\CIMV2" -computername $strComputer -Filter "LocalAccount = True" 

$colItems | Sort-Object @{ e={$_.Caption }; asc=$true } | Format-Table {$_.Caption }

foreach ($objItem in $colItems) {
      write-host "Account Type: " $objItem.AccountType
      write-host "Caption: " $objItem.Caption
      write-host "Description: " $objItem.Description
      write-host "Disabled: " $objItem.Disabled
      write-host "Domain: " $objItem.Domain
      write-host "Full Name: " $objItem.FullName
      write-host "Installation Date: " $objItem.InstallDate
      write-host "Local Account: " $objItem.LocalAccount
      write-host "Lockout: " $objItem.Lockout
      write-host "Name: " $objItem.Name
      write-host "Password Changeable: " $objItem.PasswordChangeable
      write-host "Password Expires: " $objItem.PasswordExpires
      write-host "Password Required: " $objItem.PasswordRequired
      write-host "SID: " $objItem.SID
      write-host "SID Type: " $objItem.SIDType
      write-host "Status: " $objItem.Status
      write-host
}
