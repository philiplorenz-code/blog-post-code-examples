# Install OpenSSH
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Create Firewall rule
$params = @{
  Name = 'OpenSSH-Server-In-TCP'
  DisplayName = 'OpenSSH Server (sshd)'
  Enabled = $true
  Direction = 'Inbound'
  Protocol = 'TCP'
  Action = 'Allow'
  LocalPort = 22
}

New-NetFirewallRule @params

# Start sshd Service
Start-Service sshd
Get-Service -Name sshd | Set-Service -StartupType Automatic

# Create authorized_keys Datei
$sshDir = New-Item -Path "$env:USERPROFILE\.ssh" -ItemType Directory -Force
New-Item -Path "$sshDir\authorized_keys" -ItemType File -Force