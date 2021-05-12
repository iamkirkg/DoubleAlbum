Set-Variable -Name cTrackDelta -Option AllScope -Scope Global -Value 34

Write-Host "Top of program, cTrackDelta = $cTrackDelta"
$cTrackDelta = 2
Write-Host "after global init, cTrackDelta = $cTrackDelta"

function MergeAlbum
	{
	#Set-Variable -Name cTrackDelta -Option AllScope
	Write-Host "cTrackDelta3a = $cTrackDelta"
	$cTrackDelta = 11
	Write-Host "cTrackDelta3b = $cTrackDelta"
	}

Write-Host "cTrackDeltaDa = $cTrackDelta"
MergeAlbum 'aaa'
Write-Host "cTrackDeltaDb = $cTrackDelta"
MergeAlbum 'bbb'
Write-Host "cTrackDeltaDc = $cTrackDelta"
