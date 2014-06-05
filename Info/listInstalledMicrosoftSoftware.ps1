Get-WmiObject -Class Win32_Product -Computer localhost `
| Select-Object Name | Where-Object {$_.Name -like 'Micro*' }