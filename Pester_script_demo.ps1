# source
# https://richardspowershellblog.wordpress.com/2018/10/15/ping-tests-with-pester/

function get-internetconnection {

  $prf = Get-NetConnectionProfile -IPv4Connectivity Internet

  $nic = $prf | Get-NetAdapter

  $ip = $prf | Get-NetIPAddress -AddressFamily IPv4

  $dg = $prf | Get-NetIPConfiguration

  $props = [ordered]@{
     NetworkName    = $prf.Name
     NetConnection  = $prf.IPv4Connectivity
     iIndex         = $prf.InterfaceIndex
     iAlias         = $prf.InterfaceAlias
     Status         = if ($nic.InterfaceOperationalStatus -eq 1){'Up'}else{'Down'}
     IPAddress      = $ip.IPAddress
     PrefixLength   = $ip.PrefixLength
     DefaultGateway = $dg.IPv4DefaultGateway | Select-Object -ExpandProperty NextHop
     DNSserver      = ($dg.DNSServer).serverAddresses
   }

  New-Object -TypeName PSobject -Property $props

}
$netinfo = get-internetconnection

Describe 'LoopBack' {

##  tests LoopBack adapter
It 'Loopback should be available' {
Test-Connection -ComputerName 127.0.0.1 -Quiet -Count 1 |
Should Be $true

}

}

Describe 'LocalNic' {

##  tests local adapter
It 'Local adapter should be available' {
Test-Connection -ComputerName $netinfo.IPAddress -Quiet -Count 1 |
Should Be $true

}

}

Describe 'DefaultGateway' {

##  tests Default Gateway
It 'Default Gateway should be available' {
Test-Connection -ComputerName $netinfo.DefaultGateway -Quiet -Count 1 |
Should Be $true

}

}

Describe 'DNSServer' {
##  tests DNS server
It 'DNS server should be available' {
Test-Connection -ComputerName $netinfo.DNSserver -Quiet -Count 1 |
Should Be $true

}

}

Describe 'Target' {

##  tests target server
It 'Target server should be available' {
Test-Connection -ComputerName MyNoneExistantServer -Quiet -Count 1 |
Should Be $true

}

}