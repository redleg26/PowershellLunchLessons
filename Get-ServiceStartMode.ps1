<#
.SYNOPSIS
   Retrieve list of Services by state and startmode
.DESCRIPTION
   
.PARAMETER <paramName>
[string]$Computername='localhost',
		[string]$StartMode='Auto',
		[string]$State='Running'
.EXAMPLE
	.\Get-ServiceStartMode.ps1 -state = "Stopped"
	.\Get-ServiceStartMode
	.\Get-ServiceStartMode -Start 'Auto' -State 'Stopped'
	Get-ServiceStartMode -StartMode 'Disabled' -Computername 'SERVER01'
#>
Function Get-ServiceStartMode {
	Param(
		[string]$Computername='localhost',
		[string]$StartMode='Auto',
		[string]$State='Running'
	)
	$filter="Startmode='$Startmode' AND state='$State'"
	Write-Host "Filter: ", $filter
	Get-CimInstance -ClassName Win32_Service -ComputerName $Computername -Filter $filter | Select-Object Name,State,Startmode 
}

Get-ServiceStartMode