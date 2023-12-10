
# NAT networking in Virtual Box is switched on
Describe 'NAT networking in Virtual Box is switched on' {

# NAT network
    It 'NAT should be on in VM' {
    Test-Connection -ComputerName 10.0.2.2 -Quiet -Count 1 |
    Should Be $true
    }
}

# Whether an Internet connection is possible
Describe 'Whether an Internet connection is possible' {

# Google DNS server
    It 'Google DNS server should be available' {
    Test-Connection -ComputerName 8.8.8.8 -Quiet -Count 1 |
    Should Be $true
    }
}

# Whether a username with the name "admin" exists
# https://stackoverflow.com/questions/49595003/checking-if-a-local-user-account-group-exists-or-not-with-powershell
# User to search for
$USERNAME = "ward"

# Search for $USERNAME in the local users
Describe "if user $USERNAME exists"{
    It "$USERNAME should be a user"{
        Get-LocalUser $USERNAME |Select-Object name |
         should be "@{Name=$USERNAME}"
    }
}


# Whether the firewall is on
# "should be "@{Enabled=True}"" if it is just $true the test allways returns green
Describe "Whether the firewall is on" {
    It "Domain Firewall should be enabled" {
        Get-NetFirewallProfile | where-object {$_.Profile -like "Domain"} | Select-Object Enabled |
        should be "@{Enabled=True}"
    }
    It  "Private Firewall should be enabled" {
        Get-NetFirewallProfile | where-object {$_.Profile -like "private"} | Select-Object Enabled |
        should be "@{Enabled=True}"
    }
    It  "Public Firewall should be enabled" {
        Get-NetFirewallProfile | where-object {$_.Profile -like "Public"} | Select-Object Enabled |
        should be "@{Enabled=True}"
    }
}

# Are VirtualBox Guest Additions installed
# https://learn.microsoft.com/en-us/powershell/module/packagemanagement/get-package?view=powershellget-2.x
Describe 'VirtualBox Guest Additions are installed' {

    # Look for VirtualBox Guest Additions
    It 'VirtualBox Guest Additions should be installed' {
    get-package "Oracle VM VirtualBox Guest Additions 7.0.12" |
    Should Be $true
    }
}

# check if trile edition has expired
Describe 'GracePeriod' {

    it 'Lisence should not be expired' {
        $info = Get-CimInstance -ClassName SoftwareLicensingProduct
        [math]::Round($($info.GracePeriodRemaining/24/60), 0) |
        should BeGreaterThan 0
    }
}

# Does not work $_.Languagetag 
# If your keyboard layout is "Belgian (period) or not.
# https://community.spiceworks.com/topic/2240069-current-keyboard-layout-via-cmd-or-powershell

# try {
#     Write-Verbose "Searching for LanguageList"
#     Get-WinUserLanguageList | Where-Object {$_.Languagetag -like "nl-BE"}
#     Write-Verbose '"nl-BE" IS in LanguageList'
# }

# catch {
#     '"nl-BE" NOT in LanguageList' | Write-Error
# }


# Microsoft Visual Studio Code is installed
# https://learn.microsoft.com/en-us/powershell/module/packagemanagement/get-package?view=powershellget-2.x
Describe 'Microsoft Visual Studio Code is installed' {

# Look for Microsoft Visual Studio Code package
    It 'Microsoft Visual Studio Code should be installed' {
    get-package "Microsoft Visual Studio Code (user)" |
    Should Be $true
    }
}


# Microsoft Visual Studio Code is running
Describe 'Microsoft Visual Studio Code is running' {

# Look for Microsoft Visual Studio Code process
    It 'Microsoft Visual Studio Code should be running' {
    Get-Process "code" |
    Should Be $true
    }
}


Describe 'https://sinners.be is available' {

##  tests https://sinners.be is available server
    It 'sinners.be is available server should be available' {
    Test-Connection -ComputerName 193.191.186.133:80 is available -Quiet -Count 1 |
    Should Be $true
    }
}