$UserName = "ansible"
$Password = "SicheresPasswort123!"
$userParams = @{
  Name = $UserName
  Description = "Benutzerkonto für Ansible-Automatisierung"
  Password = (ConvertTo-SecureString -AsPlainText $Password -Force)
  AccountNeverExpires = $true
  PasswordNeverExpires = $true
  UserMayNotChangePassword = $true
}
$AnsibleUser = New-LocalUser @userParams
$AnsibleUser | Add-LocalGroupMember -Group "Administrators"