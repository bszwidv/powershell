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
$forms = @("Fi2015", "Ik2015", "A2015", "K2015a", "K2015b")

$forms | foreach-Object {
	$form = $_
	
	new-ADOrganizationalUnit $form -Path "ou=BszUsers,dc=bsz,dc=edu"
	New-ADGroup -Name $form -GroupScope Universal -GroupCategory Security
}
		
# TODO move groups to corresponding OUs - modify this code
#Move-ADObject -Identity Fi2015 -TargetPath 'ou=BszUsers,ou=Fi2015,dc=bsz,dc=edu'
#Move-ADObject -Identity Ik2015 -TargetPath 'ou=BszUsers,ou=Ik2015,dc=bsz,dc=edu'
#Move-ADObject -Identity A2015 -TargetPath 'ou=BszUsers,ou=A2015,dc=bsz,dc=edu'
#Move-ADObject -Identity K2015a -TargetPath 'ou=BszUsers,ou=K2015a,dc=bsz,dc=edu'
#Move-ADObject -Identity K2015b -TargetPath 'ou=BszUsers,ou=K2015b,dc=bsz,dc=edu'