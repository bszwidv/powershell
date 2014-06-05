#ad1.msh
#Illustrates using AD from MSH
#Author: Ap
#
# Define search user
$lastName = "Godron"
$firstName = "Brigitte"

$search = $firstName + " " + $lastName

Write-Host $search

# Define root
$Root = New-Object DirectoryServices.DirectoryEntry 'LDAP://bsz.edu/ou=Lehrer,ou=BszLehrer;DC=bsz;DC=edu'

# Now create a searcher and set base to base of user Container
$Searcher = New-Object DirectoryServices.DirectorySearcher
$Searcher.SearchRoot = $root

#Now find user "Brigitte Godron" and display her
$users= $searcher.findall() | where {$_.properties.samaccounttype -eq 805306368} 
Write-Host "There are $($users.count) users in the $($root.name) container:`n"

foreach ($user in $users){
  $up=$user.properties
	
#only do it for users...

  if ($up.samaccounttype -eq 805306368){
	  if($up.name -eq $search){
      Write-Host "User: $($up.name) `nDN:   $($up.distinguishedname)`n"
			Write-Host $up.PasswordRequired
			}
  }
}
