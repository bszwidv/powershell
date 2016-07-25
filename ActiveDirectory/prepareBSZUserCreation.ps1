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
$forms = @("Fi2016", "Ik2016", "A2016", "B2016a", "B2016b")

$forms | foreach-Object {
	$form = $_
	
	new-ADOrganizationalUnit $form -Path "ou=BszUsers,dc=bsz,dc=edu"
	New-ADGroup -Name $form -GroupScope Universal -GroupCategory Security
}
		
# TODO move groups to BszGroups
#Move-ADObject -Identity Fi2016 -TargetPath 'ou=BszGroups,dc=bsz,dc=edu'