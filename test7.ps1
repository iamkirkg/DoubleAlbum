$dirDisc1 = 'C:\tmp\wmp\Led Zeppelin\Physical Graffiti Disc 1'
$dirNew   = 'C:\tmp\wmp\Led Zeppelin\Physical Graffiti'

if (Test-Path $dirDisc1) { Write-Host dirDisc1 exists } else { Write-Host ERROR dirDisc1 does not exist! }
if (Test-Path $dirNew) { Write-Host dirNew exists } else { Write-Host ERROR dirNew does not exist! }

Get-Childitem -Force -LiteralPath $dirDisc1 -Recurse | Move-Item -Dest $dirNew

#Move-Item -Path $dirDisc1 -Destination $dirNew
#Move-Item -LiteralPath $dirDisc1 -Destination $dirNew

#This moves the entire disc1 folder beneath dirNew
#Move-Item -LiteralPath $dirDisc1 -Destination $dirNew

