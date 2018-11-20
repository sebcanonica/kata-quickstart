<#
	.SYNOPSIS
	Run build and tests periocically and revert repository if anything fails
	.PARAMETER Seconds
	Time, in seconds, between runs
	.PARAMETER Loop
	Restart the timer automatically
#>
param (
	[Int32] $Seconds = 120,
	[switch] $Loop
)

Import-Module .\Tools.psm1

function Start-Countdown {
	<#
	.SYNOPSIS Provide a graphical countdown if you need to pause a script for a period of time
	.PARAMETER Seconds Time, in seconds, that the function will pause
	.PARAMETER Messge Message you want displayed while waiting
	.EXAMPLE Start-Countdown -Seconds 30 -Message Please wait while Active Directory replicates data...
	.NOTES Author: Martin Pugh Twitter: @thesurlyadm1n Spiceworks: Martin9700 Blog: www.thesurlyadmin.com Changelog: 2.0 New release uses Write-Progress for graphical display while couting down. 1.0 Initial Release
	.LINK http://community.spiceworks.com/scripts/show/1712-start-countdown
	#>
	param(
		[Int32] $Seconds = 10,
		[string] $Message = "Pausing for 10 seconds..."
	)
	if ($Seconds -gt 0) {
		foreach ($Count in (1..$Seconds)) {
			Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
			Start-Sleep -Seconds 1
		}
		Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed
	}
}


do {
	Start-Countdown -Seconds $Seconds -Message "Make build AND tests pass (Ctr-C to stop)"

	Test-Solution -OnFailure { Reset-Repository }  -OnSuccess { Write-Host "Well done!" -ForegroundColor Green }
} while ($Loop)