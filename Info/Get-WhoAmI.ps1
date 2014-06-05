#get-whoami.ps1
#author:  Thomas Lee  tfl@psp.co.uk
#tested with PowerShell RC1.1

function Get-WhoAmI { if ($env:USERNAME -eq "Administrator")
                         {$p="*"} 
                      else 
                         {$p=""}
 "You are logged on as: $p$env:USERDOMAIN\$env:USERNAME$p" 
 }
#set an alias to this command
set-alias -name Get-WhoAmI -value whoami