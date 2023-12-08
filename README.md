# OS-Windows_Casestudy

This Github repo is for the cours OS (operating systems) in ITFactory at Thomasmore Geel. 

## GOAL of the project:

The goal is to learn use ing powershell and windows in my case making a script using Pester Test (infrastructure test).

## Table of contents

This documentation was made with and for windows 10 enterprise. And goes over the folowing things.
- [OS-Windows\_Casestudy](#os-windows_casestudy)
  - [GOAL of the project:](#goal-of-the-project)
  - [Table of contents](#table-of-contents)
  - [Details of het project](#details-of-het-project)
- [get-member](#get-member)
- [Pester test](#pester-test)
  - [Describe](#describe)
  - [NAT networking](#nat-networking)
  - [Internet connection](#internet-connection)
  - [Check username](#check-username)
- [Links and referenses](#links-and-referenses)

## Details of het project

-	NAT networking in Virtual Box is switched on
-	Whether an Internet connection is possible
-	Whether a username with the name "admin" exists
-	Whether the firewall is on
-	Whether the virtual box guest additions are installed in the virtual machine.
-	How long your device can work with a trial edition.
-	If the keyboard layout "Belgian (period) is in the LanguageList.

And

-	Whether VSCode is installed.
-	Whether VSCode is running
-	Whether https://sinners.be is available.

At the end of the Pester test, write information about your Pester test to one of the log files in event viewer.

# get-member

Don't forget Get-Member !!! it exists.

# Pester test

Pester is a testing and mocking framework for PowerShell.

Pester provides a framework for writing and running tests. Pester is most commonly used for writing unit and integration tests, but it is not limited to just that. It is also a base for tools that validate whole environments, computer deployments, database configurations and so on. [Readmore](https://pester.dev/docs/quick-start).

## Describe
A peter test should are structured like this.
```
Describe 'Name of the test' {
    It 'What its checking for' {
    Testscript or command |
    Should Be $true #, $false a number (greater then, less then, equel to )
    }

    # There can be multiple test in 1 Describe.

    It 'What its checking for' {
    Testscript or command |
    Should Be $true
    }
}
```

## NAT networking
Test if the 'Default gateway' add 10.0.2.2 is available if it is that means the NAT network adapter is correctly connected.
```
Test-Connection -ComputerName 10.0.2.2 -Quiet -Count 1 
```

## Internet connection
Test if the google DNS servers are available.
```
Test-Connection -ComputerName 8.8.8.8 -Quiet -Count 1
```

## Check username
Test if the username is present, by geting the localuser list and testing for the name.
```
Get-LocalUser $USERNAME |Select-Object name | should be "@{Name=$USERNAME}"
```

# Links and referenses

[pester.dev](https://pester.dev/docs/quick-start)

[Ping tests with Pester](https://richardspowershellblog.wordpress.com/2018/10/15/ping-tests-with-pester/)

[Checking if a local user account/ group exists or not with Powershell](https://stackoverflow.com/questions/49595003/checking-if-a-local-user-account-group-exists-or-not-with-powershell)

[Current keyboard layout via cmd or powershell](https://community.spiceworks.com/topic/2240069-current-keyboard-layout-via-cmd-or-powershell)

[Get-Package ](https://learn.microsoft.com/en-us/powershell/module/packagemanagement/get-package?view=powershellget-2.x)