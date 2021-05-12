<#
Test the 'GetMetadata' function.
#>

# ===========================================================================
#
# Include common functions

. .\Music.ps1

# ===========================================================================
#
# The start of the program.

$fVerbose = $false
$fReadonly = $false
$dirRoot = ''

foreach ($arg in $args)
	{
	if ($arg -eq 'verbose')
		{
		$fVerbose = $true
		Write-Host "Verbose!"
		}
	elseif ($arg -eq 'test')
		{
		$fReadonly = $true
		Write-Host "Running test (read-only) mode"
		}
	else
		{
		$dirRoot = $arg
		Write-Host "Directory root = $dirRoot"
		}
	}

# Process the directory passed in.
foreach ($file in Get-ChildItem -LiteralPath $dirRoot) {
	Write-Host $dirRoot\$file

	$meta = GetMetadata $dirRoot\$file $fVerbose

	Write-Host "`tWM/AlbumTitle : " $meta['WM/AlbumTitle'].iDx $meta['WM/AlbumTitle'].type $meta['WM/AlbumTitle'].value
	Write-Host "`tTitle : " $meta['Title'].iDx $meta['Title'].type $meta['Title'].value
	Write-Host "`tWM/Track : " $meta['WM/Track'].iDx $meta['WM/Track'].type $meta['WM/Track'].value
	Write-Host "`tWM/TrackNumber : " $meta['WM/TrackNumber'].iDx $meta['WM/TrackNumber'].type $meta['WM/TrackNumber'].value
	
	#foreach ($h in $meta.GetEnumerator()) {
	#	 Write-Host $($h.Name) $($h.Value).iDx $($h.Value).type $($h.Value).value
	#}
}

# ---------------------------------------------------------------------------
