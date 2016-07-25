#========================= reset password
# state: working
#
# TODO add synopsis
#
$form = Read-Host -Prompt "Form (e.g. Fi2015)"

$newPassword = Read-Host -Prompt "Provide New Password" -AsSecureString

$users = Get-ADGroupMember -Identity $form

foreach ($user in $users) {	set-ADAccountPassword -Identity $user -NewPassword $newPassword }