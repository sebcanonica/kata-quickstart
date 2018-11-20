function Reset-Repository {
	Write-Host "Reseting!!!" -ForegroundColor Red
	git reset --hard
}

function Test-Solution {
    param(
        [scriptblock] $OnFailure,
        [scriptblock] $OnSuccess
    )
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
        & $OnFailure
    } else {

        # Run tests
        ~\.nuget\packages\nunit.consolerunner\3.9.0\tools\nunit3-console.exe  .\MyLibrary\MyLibrary.csproj
        if( $LastExitCode -ne 0) {
            & $OnFailure
        } else {
            & $OnSuccess
        }

    }
}