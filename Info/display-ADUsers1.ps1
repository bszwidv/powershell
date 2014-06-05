#ad1.ps1
#Illustrates using AD from PowerShell
#Author: Thomas Lee
#Checked with PowerShell RC1.1

# The script prints out all the user in the Users OU in the Kapoho domain
# This assumes a domain called kapoho.net - adjust for your own domain
# This assumes a DC called kona.kapoho.net - adjust for your own domain

# Define root
$Root = New-Object DirectoryServices.DirectoryEntry 'LDAP://kona.kapoho.net/cn=Users;DC=kapoho;DC=net'

# Now create a searcher and set base to base of user Container
$Searcher = New-Object DirectoryServices.DirectorySearcher
$Searcher.SearchRoot = $root

#Now find all users and display them
$users= $searcher.findall() | where {$_.properties.samaccounttype -eq 805306368} 
Write-Host "There are $($users.count) users in the $($root.name) container in Kapoho.Net:`n"

foreach ($user in $users){
  $up=$user.properties
  
#only do it for users...

  if ($up.samaccounttype -eq 805306368){
  
    Write-Host "User: $($up.name) `nDN:   $($up.distinguishedname)`n"
    }
}