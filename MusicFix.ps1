<#

  This is the driver program.  Cut'n'paste the command in here,
  run it, then move the command over to the bottom of MusicFixed.ps1.

  REVIEW: What happened here?
  MusicTtoZ\Yo-Yo Ma\Bach- Six Unaccompanied Cello Suites
         5,596,977 01 Track 1.wma
         8,422,321 02 Track 2.wma
         5,668,477 03 Track 3.wma
		 ...
        10,007,789 17 Track 17.wma
         5,692,349 18 Track 18.wma
		 ...
         7,849,987 19 Suite No. 2, Prelude.wma
         6,681,925 20 Allemande.wma
         4,023,431 21 Courante.wma
         ...
         7,862,069 35 Gavotte.wma
         8,875,369 36 Gigue.wma
#>
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
$cTrackDelta = 0

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

# ---------------------------------------------------------------------------

$dirRoot = "d:\\tmp\\music"
$dirAlbum = "$dirRoot\Kamasi Washington\The Epic"
$szAlbum = $dirAlbum -replace '.*\\',''
$maxTrack0 = 0

$dirDisc = "$dirRoot\Kamasi Washington\The Epic [Disc 1]"
$maxTrack1 = MergeAlbum $dirDisc $dirAlbum $szAlbum $maxTrack0 $fReadonly
if ($fVerbose) { Write-Host "Returned maxTrack = $maxTrack1" }
$dirDisc = "$dirRoot\Kamasi Washington\The Epic 2-2"
$maxTrack2 = MergeAlbum $dirDisc $dirAlbum $szAlbum $maxTrack1 $fReadonly
if ($fVerbose) { Write-Host "Returned maxTrack = $maxTrack2" }
$dirDisc = "$dirRoot\Kamasi Washington\The Epic [Disc 3]"
$maxTrack3 = MergeAlbum $dirDisc $dirAlbum $szAlbum $maxTrack2 $fReadonly
if ($fVerbose) { Write-Host "Returned maxTrack = $maxTrack3" }

# ---------------------------------------------------------------------------

