ls | ForEach-Object { Split-Path -Qualifier $_.FullName }
# return drive letter (e:)
ls | ForEach-Object { Split-Path  $_.FullName }
# return path to fileName | dirName

