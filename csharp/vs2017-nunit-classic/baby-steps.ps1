
<#
	.SYNOPSIS Run build and tests periocically and revert repository if anything fails
	.PARAMETER Seconds Time, in seconds, between runs
	.PARAMETER Loop Restart the timer automatically
#>
param (
	[Int32] $Seconds = 120,
	[switch] $Loop
)

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


function Reset-Repository {
	Write-Host "Reseting!!!" -ForegroundColor Red
	git reset --hard
}



do {
	Start-Countdown -Seconds $Seconds -Message "Make build AND tests pass (Ctr-C to stop)"

	# Build Solution
	$path = & "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere" -latest -products * -requires Microsoft.Component.MSBuild -property installationPath
	if (! $path) {
		Throw "Could not locate vswhere"
	}
	$path = join-path $path 'MSBuild\15.0\Bin\MSBuild.exe'
	if (! (test-path $path) ) {
		Throw "Could not locate MSBuild"
	}
	& $path .\MyLibrary\MyLibrary.sln

	if( $LastExitCode -ne 0) {
		Reset-Repository
	} else {

		# Run tests
		~\.nuget\packages\nunit.consolerunner\3.9.0\tools\nunit3-console.exe  .\MyLibrary\MyLibrary.csproj
		if( $LastExitCode -ne 0) {
			Reset-Repository
		} else {
			Write-Host "Well done!" -ForegroundColor Green
		}

	}

} while ($Loop)