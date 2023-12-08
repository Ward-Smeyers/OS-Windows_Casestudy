
# NAT networking in Virtual Box is switched on
Describe 'NAT networking in Virtual Box is switched on' {

# NAT network
It 'NAT should be on in VM' {
Test-Connection -ComputerName 10.0.2.0 -Quiet -Count 1 |
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
try {
    Write-Verbose "Searching for $($USERNAME) in LocalUser DataBase"
    Get-LocalUser $USERNAME
    Write-Verbose "User $($USERNAME) was found"
}

# If user name not found print
catch [Microsoft.PowerShell.Commands.UserNotFoundException] {
    "User $($USERNAME) was not found" | Write-Warning
}

# error handeler
catch {
    "An unspecifed error occured" | Write-Error
}


# Whether the firewall is on
try {
    Write-Verbose "Searching for firewall"
    Get-NetFirewallProfile | Select-Object Enabled
    Write-Verbose "Firewall is Enabled"
}

catch {
    "Firewall is disabled" | Write-Error
}

# Werkt niet !!!
# check if trile edition has expired
# Describe 'GracePeriod' {

#     it 'GracePeriod ' {
#         $ts = Get-WmiObject -Class Win32_TerminalServiceSetting -Namespace "root\CIMV2\TerminalServices"
#         $ts.GetGracePeriodDays() | should be -gt 0
#     }
# }



# If your keyboard layout is "Belgian (period) or not.
# https://community.spiceworks.com/topic/2240069-current-keyboard-layout-via-cmd-or-powershell
try {
    Write-Verbose "Searching for LanguageList"
    Get-WinUserLanguageList | Where-Object {$_.Languagetag -like "nl-BE"}
    Write-Verbose '"nl-BE" IS in LanguageList'
}

catch {
    '"nl-BE" NOT in LanguageList' | Write-Error
}


# Microsoft Visual Studio Code is installed
# https://learn.microsoft.com/en-us/powershell/module/packagemanagement/get-package?view=powershellget-2.x
Describe 'Microsoft Visual Studio Code is installed' {

# Look for Microsoft Visual Studio Code package
It 'Microsoft Visual Studio Code should be installed' {
get-package "Microsoft Visual Studio Code (user)" |
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