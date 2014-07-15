# prepareBSZUserCreation
# created by ap 14.7.2014
# modified:

<#
.SYNOPSIS
Prepare add users for coming term.

.DESCRIPTION
Prepare add users for coming term, i.e. create ADObjects (group, OU).

.PARAMETER FirstParameter
No parameters required.

.INPUTS
No objects can be piped to this script.

.OUTPUTS
No outputs at the moment. Should log results.

.EXAMPLE
run: prepareBSZUserCreation.ps1

.LINK
No links to further documentation

.NOTES
No comments at the moment.
#>
$forms = @("Fi2014", "Ik2014", "A2014", "K2014a", "K2014b")

$forms | foreach-Object {
	$form = $_
	
	new-ADOrganizationalUnit $form -Path "ou=BszUsers,dc=bsz,dc=edu"
	New-ADGroup -Name $form -GroupScope Universal -GroupCategory Security

	Move-ADObject -Identity $form -TargetPath 'ou=BszUsers,ou=$form,dc=bsz,dc=edu'

}
		
# create OUs
#new-ADOrganizationalUnit Fi2014 -Path "ou=BszUsers,dc=bsz,dc=edu"
#new-ADOrganizationalUnit Ik2014 -Path "ou=BszUsers,dc=bsz,dc=edu"
#new-ADOrganizationalUnit A2014 -Path "ou=BszUsers,dc=bsz,dc=edu"
#new-ADOrganizationalUnit K2014a -Path "ou=BszUsers,dc=bsz,dc=edu"
#new-ADOrganizationalUnit K2014b -Path "ou=BszUsers,dc=bsz,dc=edu"

# create Groups
#New-ADGroup -Name Fi2014 -GroupScope Universal -GroupCategory Security
#New-ADGroup -Name Ik2014 -GroupScope Universal -GroupCategory Security
#New-ADGroup -Name A2014 -GroupScope Universal -GroupCategory Security
#New-ADGroup -Name K2014a -GroupScope Universal -GroupCategory Security
#New-ADGroup -Name K2014b -GroupScope Universal -GroupCategory Security

# TODO move groups to corresponding OUs
##Move-ADObject -Identity Fi2014 -TargetPath 'ou=BszUsers,ou=Fi2014,dc=bsz,dc=edu'
#Move-ADObject -Identity Ik2014 -TargetPath 'ou=BszUsers,ou=Ik2014,dc=bsz,dc=edu'
#Move-ADObject -Identity A2014 -TargetPath 'ou=BszUsers,ou=A2014,dc=bsz,dc=edu'
#Move-ADObject -Identity K2014a -TargetPath 'ou=BszUsers,ou=K2014a,dc=bsz,dc=edu'
#Move-ADObject -Identity K2014b -TargetPath 'ou=BszUsers,ou=K2014b,dc=bsz,dc=edu'