<#

To get the darned thing to run, in an admin shell
	powershell.exe Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

We want to glue multiple "CDn" music directories into one.

	M:\Glerum Music\Led Zeppelin\Blasphemy (1975 Earls Court, London) CD1
	M:\Glerum Music\Led Zeppelin\Blasphemy (1975 Earls Court, London) CD2
	M:\Glerum Music\Led Zeppelin\Blasphemy (1975 Earls Court, London) CD3

Is it single- or double-quotes?  I can never remember.
Remarkably, this works, with the ampersand:
	f:\work\DoubleAlbum>powershell.exe .\DoubleAlbum.ps1 'f:\Kirk\Music\Neil Young "&" Crazy Horse' test

---------------------

1) Create the new directory, without the ' CD1'
2) For each file in the directory, update WM/AlbumTitle
	b) Update WM/AlbumTitle
	c) Move the file to its new name in the new directory
4) Delete the empty CDn directory

M:\Glerum Music\Led Zeppelin\Blasphemy (1975 Earls Court, London) CD1
	01. Rock 'n' Roll_[plixid.com].mp3
	*  21  Title                       0    0   STRING  "1. Rock 'n' Roll (Live  1975)"
	*  22  Author                      0    0   STRING  "Led Zeppelin"
	*  23  WM/AlbumTitle               0    0   STRING  "Blasphemy (24-25 may 1975 Earls Court, London) (3CD) (Bootleg)"
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
$prevAlbum = ''
$cTrackDelta = 0
$maxTrack = 0

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
	elseif ($arg -match "Exclusion")	# AlbumExclusion.txt
		{
		$rgAlbumExclusion = (get-content $arg)
		Write-Host "Exclusion list: $arg"
		}
	elseif ($arg -match "Inclusion")	# AlbumInclusion.txt
		{
		$rgAlbumInclusion = (get-content $arg)
		Write-Host "Inclusion list: $arg"
		}
	else
		{
		$dirRoot = $arg
		Write-Host "Directory root = $dirRoot"
		}
	}

# How many (properly numbered) music files are there in all these directories?
$cTrackTotal = 0
foreach ($dirDisc in Get-ChildItem -Path $dirRoot -Recurse -Include '*CD*' | Where-Object { $_.Attributes -match ".*Directory.*" } | Sort-Object $_.Fullname ) {
	if ($fVerbose) { Write-Host "Search dir = $dirDisc" }
	foreach ($fileMusic in Get-ChildItem -LiteralPath $dirDisc) {
		if ($fileMusic -match '^\d\d .*\.(mp3|wma)$') {
			$cTrackTotal++
		}
	}
}
if ($fVerbose) { Write-Host "Count of files = $cTrackTotal" }

# Process all the directories named 'Whatever CDn'
foreach ($dirDisc in Get-ChildItem -Path $dirRoot -Recurse -Include '*CD*' | Where-Object { $_.Attributes -match ".*Directory.*" } | Sort-Object $_.Fullname )
	{
	$dirAlbum = $dirDisc -replace ' CD[ \d]+$',''
	$szAlbum = $dirAlbum -replace '.*\\',''

	if ($dirAlbum -ne $prevAlbum)
		{
		# We're starting a new (combined) album, a new folder.
		Write-Host "====== $dirAlbum ======"
		$cTrackDelta = 0
		$prevAlbum = $dirAlbum
		}

	# Move the files from $dirDisc (Foo CD1) to $dirAlbum (Foo).
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $cTrackTotal $fReadonly

	# Update the delta, for the next album.
	$cTrackDelta = $maxTrack
	}

# ---------------------------------------------------------------------------
