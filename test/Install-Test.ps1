#Requires -Version 5

param(
    [String[]]
    $Hash # specify commit hash to test
)

$FILES_CHANGED = $(git show $Hash --pretty="" --name-only) -Split "\n"
$APPS_CHANGED = @()

foreach ($_ in $FILES_CHANGED) {
    if ($_ -like "bucket*") {
        $Name = $_ -Replace "bucket/" -Replace ".json"
        $APPS_CHANGED += $Name
    }
}

# no apps changed to install test
if ($APPS_CHANGED.Count -eq 0) {
    Write-Host "No apps changed." -ForegroundColor Green
    exit 0
}

Write-Host "Apps changed: $APPS_CHANGED" -ForegroundColor DarkYellow

$BUCKET_NAME = "xn"

# One by one, install app that have been changed as test.
foreach ($APP in $APPS_CHANGED) {
    Write-Host "Test installing $APP" -ForegroundColor Cyan
    scoop install $BUCKET_NAME/$APP
}
