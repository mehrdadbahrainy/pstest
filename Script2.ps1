#
# Script2.ps1
#

<#

# List all entries
Get-HostEntry

# List matching entries
Get-HostEntry *.local
Get-HostEntry mysite.local

# Add an entry
Add-HostEntry mysite.local 127.0.0.1

# Change an entry's IP address
Set-HostEntry mysite.local 127.0.0.2

# Add a comment
Set-HostEntry mysite.local -Comment Excellent

# Rename a host
Get-HostEntry mysite.local | Set-HostEntry mysite2.local

# Disable (comment out) entries
Disable-HostEntry mysite.local

# Enable (uncomment) entries
Enable-HostEntry mysite.local

# Remove entries
Remove-HostEntry mysite.local

# Remove matching entries
Remove-HostEntry *.local

# Disable all loopback entries
Get-HostEntry | ?{$_.Address -eq "127.0.0.1"} | Disable-HostEntry


Set-ExecutionPolicy RemoteSigned


#>

if(-Not (Test-Path Env:_Tfs_Dev))
{
    Write-Host "Create environment variable"
    $env:_Tfs_Dev = ""
    Write-Host "Environment variable created"
}

Install-Module PsHosts

$hostEntry = ""

$uiFarmeworkExists = Get-HostEntry $hostEntry
if(-not $uiFarmeworkExists)
{
    Add-HostEntry $hostEntry 127.0.0.1
}

$succeeded = import-module WebAdministration
if (($succeeded -ne $null) -and ($succeeded.GetType() -eq [System.Exception])) 
{
  #Could not import, trying to snapin
  add-pssnapin WebAdministration
}

$UiFrameworkSiteName = ""
$UiFrameworkSitePath = "IIS:\Sites\$UiFrameworkSiteName"
$UiFrameworkAppPoolsPath = "IIS:\AppPools\$UiFrameworkSiteName"

if (Test-Path $UiFrameworkSitePath) 
{ 
	Remove-Item $UiFrameworkSitePath
}


if (Test-Path $UiFrameworkAppPoolsPath) 
{ 
	Remove-Item $UiFrameworkAppPoolsPath
}

New-Item $UiFrameworkAppPoolsPath
New-Item $UiFrameworkSitePath -bindings @{protocol="http";bindingInformation=":80:$UiFrameworkSiteName"} -physicalPath "$env:_Tfs_Dev"
Set-ItemProperty $UiFrameworkSitePath -name applicationPool -value $UiFrameworkSiteName
Write-Host "$UiFrameworkSiteName created."
