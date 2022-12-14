<#

To get the darned thing to run, in an admin shell
	powershell.exe Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

We want to glue multiple "Disc n" or "CDn" music directories into one.
	The Beatles\Anthology 2 [Disc 1]
	The Beatles\Anthology 2 [Disc 2]
	Led Zeppelin\Blasphemy (1975 Earls Court, London) CD1
	Led Zeppelin\Blasphemy (1975 Earls Court, London) CD2
	Led Zeppelin\Blasphemy (1975 Earls Court, London) CD3

Is it single- or double-quotes?  I can never remember.
Remarkably, this works, with the ampersand:
	f:\work\DoubleAlbum>powershell.exe .\DoubleAlbum.ps1 'f:\Kirk\Music\Neil Young "&" Crazy Horse' test

TODO:
  - Should we crap out on directories without '03 foo.wma' naming convention?
    What does it do right now on those folders?
  - In fullblown read-write mode, run the read-only test first, on each set
    of directories.
  - We need some code to glue together misnamed subdirs:
       Return to the Valley of the Go-Go's
       Return to the Valley of the Go-Go's Disc 2
	   Goodbye Yellow Brick Road [Deluxe Edition] Disc 1
	   Goodbye Yellow Brick Road
	   Joe Satriani-Eric Johnson-Steve Vai\G3- Live in Concert
	   g3\G3 Live (Rockin' In The Free World) [UK] Disc 2
       Pete Townshend Live- A Benefit for Maryville Academy
       Pete Townshend Live- A Benefit for Maryville Acadamy Disc 2

---------------------

1) Create the new directory, without the ' Disc 1' or ' CD1'
2) For each file in the directory, update WM/AlbumTitle
	b) Update WM/AlbumTitle
	c) Move the file to its new name in the new directory
4) Delete the empty Disc1 or CDn directory

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
foreach ($dirDisc in Get-ChildItem -Path $dirRoot -Recurse -Include '*Disc ?*','*CD*' | Where-Object { $_.Attributes -match ".*Directory.*" } | Sort-Object $_.Fullname ) {
	if ($fVerbose) { Write-Host "Search dir = $dirDisc" }
	foreach ($fileMusic in Get-ChildItem -LiteralPath $dirDisc) {
		if ($fileMusic -match '^\d\d .*\.(mp3|wma)$') {
			$cTrackTotal++
		}
	}
}
if ($fVerbose) { Write-Host "Count of files = $cTrackTotal" }

# Process all the directories named 
#	'Whatever CDn'
#	'Whatever Disc n'
#	'Whatever [Disc n]'
foreach ($dirDisc in Get-ChildItem -Path $dirRoot -Recurse -Include '*Disc ?*','*CD*' | Where-Object { $_.Attributes -match ".*Directory.*" } | Sort-Object $_.Fullname )
	{
	Write-Host "Found: $dirDisc"
	$dirAlbum = $dirDisc -replace ' Disc \d+$',''
	$dirAlbum = $dirAlbum -replace ' \[Disc \d+\]',''
	$dirAlbum = $dirAlbum -replace ' CD[ \d]+$',''
	$szAlbum = $dirAlbum -replace '.*\\',''

	if ($dirAlbum -ne $prevAlbum)
		{
		# We're starting a new (combined) album, a new folder.
		Write-Host "====== $dirAlbum ======"
		$cTrackDelta = 0
		$prevAlbum = $dirAlbum
		}

	# Move the files from $dirDisc (Foo Disc 1 or Foo CD1) to $dirAlbum (Foo).
	if ($fVerbose) { Write-Host "MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $cTrackTotal $fReadonly" }
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $cTrackTotal $fReadonly

	# Update the delta, for the next album.
	$cTrackDelta = $maxTrack
	}

# ---------------------------------------------------------------------------
