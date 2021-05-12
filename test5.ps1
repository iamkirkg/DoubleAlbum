$f1 = '\\kona\musichome\Soundtrack\The Nutcracker- The Motion Picture Disc 1\folder.jpg'
#$f2 = '\\kona\musichome\Soundtrack\The Nutcracker- The Motion Picture Disc 2\folder.jpg'
#$f2 = '\\kona\musichome\Soundtrack\The Nutcracker- The Motion Picture Disc 2\AlbumArtSmall.jpg'
$f2 = '\\kona\musichome\Soundtrack\The Nutcracker- The Motion Picture Disc 2\FileMissing.jpg'
Write-Host "f1 = $f1"
Write-Host "f2 = $f2"

#Write-Host '==-----------------'
#Compare-Object -ReferenceObject $(Get-Content $f1) -DifferenceObject $(Get-Content $f2)
#Compare-Object -ReferenceObject $(Get-Content $f1) -DifferenceObject $(Get-Content $f2) | Where-Object { $_SideIndicator -ne '--' }
#Write-Host '==-----------------'

if (Compare-Object -ReferenceObject $(Get-Content $f1) -DifferenceObject $(Get-Content $f2) | Where-Object { $_SideIndicator -ne "--" })
	{
	Write-Host "doesn't match"
	}
else { Write-Host "match" }

$fMatch = (Compare-Object -ReferenceObject $(Get-Content $f1) -DifferenceObject $(Get-Content $f2) | Where-Object { $_SideIndicator -ne "--" })
Write-Host "fMatch = " $fMatch

#if ($obj) { Write-Host "obj"} else { Write-Host "no obj" }
#foreach ($diff in $obj) { Write-Host $diff.SideIndicator }
#
#	Compare-Object (gc $f1) (gc $f2) |
#	%{
#		"xxxx"
#		Write-Host "hello [" $_.SideIndicator "]"
#		if ($_.SideIndicator -eq "<=") {"$($_.InputObject) exists in file 1"}
#		if ($_.SideIndicator -eq "=>") {"$($_.InputObject) exists in file 2"}
#	}

