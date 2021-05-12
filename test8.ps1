$dirDisc1 = 'C:\tmp\wmp\Led Zeppelin\Physical Graffiti Disc 1'
$dirNew   = 'C:\tmp\wmp\Led Zeppelin\Physical Graffiti'

Write-Host "-------------------------"
$cmd = 'MetadataEdit.exe'
Write-Host $cmd
& $cmd

Write-Host "-------------------------"
$cmd = MetadataEdit.exe c:\tmp\foo.wma show 0
Write-Host $cmd
$cmd

Write-Host "-------------------------"
Write-Host 'MetadataEdit.exe c:\tmp\foo.wma show 0'
& MetadataEdit.exe c:\tmp\foo.wma show 0

Write-Host "-------------------------"
$cmd = 'MetadataEdit.exe C:\tmp\wmp\Led Zeppelin\Physical Graffiti\01 custard pie.wma show 0'
Write-Host $cmd
$cmd

Write-Host "-------------------------"

#$cmd = 'MetadataEdit.exe 'C:\tmp\wmp\Led Zeppelin\Physical Graffiti\01 custard pie.wma' modify 0 $iAlbumTitle 1 `'$szAlbumTitle`' 0'
#Write-Host $cmd
#& $cmd
