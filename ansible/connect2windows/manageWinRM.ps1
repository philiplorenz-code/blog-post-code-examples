# Configure simple WinRM
Enable-PSRemoting -Force
# List WinRM Listeners
winrm enumerate winrm/config/Listener


#----------------------------------------------------#
# Create HTTPS-Listener and Cert
$Fqdn = "winser01.fritz.box"
$certParams = @{
  "CertStoreLocation" = "cert:\localmachine\my"
  "DnsName" = $Fqdn
  "NotAfter" = (Get-Date).AddMonths(36)
}

# Create cert and get its thumbprint
$Thumbprint = (New-SelfSignedCertificate @certParams).Thumbprint
$Thumbprint

# HTTPS-Listener
winrm create winrm/config/Listener?Address=*+Transport=HTTPS '@{Hostname="<YOUR_DNS_NAME>"; CertificateThumbprint="<COPIED_CERTIFICATE_THUMBPRINT>"}'

# Firewall rule
$params = @{
  DisplayName = "WinRM HTTPS"
  Direction = "Inbound"
  Action = "Allow"
  Protocol = "TCP"
  LocalPort = 5986
}
New-NetFirewallRule @params

# Test Connection
test-wsman $Fqdn