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

Write-Output "Apps changed: $APPS_CHANGED"

$BUCKET_NAME = "xn"

# One by one, install app that have been changed as test.
foreach ($APP in $APPS_CHANGED) {
    Write-Output "Test installing $APP..."
    scoop install $BUCKET_NAME/$APP
}
