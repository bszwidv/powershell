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

#	Move-ADObject -Identity $form -TargetPath 'ou=BszUsers,ou=$form,dc=bsz,dc=edu'

}
		
# TODO move groups to corresponding OUs
##Move-ADObject -Identity Fi2014 -TargetPath 'ou=BszUsers,ou=Fi2014,dc=bsz,dc=edu'
#Move-ADObject -Identity Ik2014 -TargetPath 'ou=BszUsers,ou=Ik2014,dc=bsz,dc=edu'
#Move-ADObject -Identity A2014 -TargetPath 'ou=BszUsers,ou=A2014,dc=bsz,dc=edu'
#Move-ADObject -Identity K2014a -TargetPath 'ou=BszUsers,ou=K2014a,dc=bsz,dc=edu'
#Move-ADObject -Identity K2014b -TargetPath 'ou=BszUsers,ou=K2014b,dc=bsz,dc=edu'