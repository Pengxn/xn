#Requires -Version 5

$Files = $(git show --pretty="" --name-only) -Split "\n"
$APPS_CHANGED = @()

foreach($_ in $Files) {
    if ($_ -like "bucket*") {
        $Name = $_ -Replace "bucket/" -Replace ".json"
        $APPS_CHANGED += $Name
    }

    Write-Output "$APPS_CHANGED"
}

# One by one, install app that have been changed as test.
foreach ($APP in $APPS_CHANGED) {
    Write-Output "Test installing $APP..."
    scoop install xn/$APP
}
