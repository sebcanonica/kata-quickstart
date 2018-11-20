<#
    .SYNOPSIS
    Run the build and tests. If it fails, reset the repository. It it succeeds, commit.
    .LINK
    https://medium.com/@kentbeck_7670/test-commit-revert-870bbd756864
    .LINK
    https://twitter.com/bberrycarmen/status/1062670041416716289
#>
Import-Module .\Tools.psm1

Test-Solution -OnFailure { Reset-Repository }  -OnSuccess {
    Write-Host "Well done! Committing..." -ForegroundColor Green
    git add *
    git commit -m "TCR autocommit"
}