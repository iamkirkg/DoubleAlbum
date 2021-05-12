<#
We want to rename one music directory.
  X\Los Angeles [Bonus Tracks]
  X\Los Angeles

Unlike the other Music programs (DoubleAlbum, AlbumMerge), this one
presumes an order of arguments.

Usage: 
  RenameAlbum <album dir> <new album name>

Here's how to escape single-quotes:

PS C:\Glerum\bin\VStudio\DoubleAlbum> .\RenameAlbum.ps1 "C:\users\kirk\music\Red Hot Chili Peppers\I'm with You [Limited Edition]" "I'm with You"

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
$dirAlbum = ''
$szAlbum = ''

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
	elseif ($dirAlbum -eq '')
		{
		$dirAlbum = $arg
		Write-Host "Directory = $dirAlbum"
		}
	else
		{
		$szAlbum = $arg
		Write-Host "New name = $szAlbum"
		}
	}

RenameAlbum $dirAlbum $szAlbum $fReadonly

# ---------------------------------------------------------------------------
