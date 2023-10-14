# ===========================================================================
#
# Music.ps1
#
# Common functions for my Music/WMP programs.

# PowerShell warning/error:
#   File foo.ps1 cannot be loaded because running scripts is disabled on this system. 
#   For more information, see about_Execution_Policies at 
#   http://go.microsoft.com/fwlink/?LinkID=135170.
# Before:
#	f:\>powershell get-executionpolicy -list
#	Scope            ExecutionPolicy
#	-----            ---------------
#	MachinePolicy    Undefined
#	UserPolicy       Undefined
#	Process          Undefined
#	CurrentUser      Undefined
#	LocalMachine     Undefined
# Command:
#	f:\>powershell set-executionpolicy -executionpolicy remotesigned -scope CurrentUser
# After:
#	f:\>powershell get-executionpolicy -list
#	Scope            ExecutionPolicy
#	-----            ---------------
#	MachinePolicy    Undefined
#	UserPolicy       Undefined
#	Process          Undefined
#	CurrentUser      RemoteSigned
#	LocalMachine     Undefined

# ---------------------------------------------------------------------------
#
# I wrote this because I can't figure out PowerShell's printf.
#
# Input: an integer
# Output: a string, the number, formatted to two decimal places
#    0 -> '00'
#    1 -> '01'
#   23 -> '23'
#  456 -> '456'

function itoa
	{
	$i = $args[0]
	if (($i -ge 0) -and ($i -lt 10))
		{
		$sz = "0{0}" -f $i
		}
	else
		{
		$sz = "{0}" -f $i
		}
	$sz
	}

# ---------------------------------------------------------------------------
#
# This function operates on a single directory.  It just renames it, and
# fixes up the metadata of its files.
#
# Input:
#   dirAlbum = full directory
#              $dirRoot\\MusicTtoZ\\The Replacements\\All for Nothing-Nothing for All Disc 2
#   szAlbum = the new album name
#              All for Nothing-Nothing for All
#   fReadonly = for real, or pretend?

function RenameAlbum
	{
	$dirSrc = $args[0]
	$szAlbum = $args[1]
	$fReadonly = $args[2]

	$cTrackTotal = 0
	foreach ($fileMusic in Get-ChildItem -LiteralPath $dirSrc) {
		if ($fileMusic -match '^\d\d\.? .*\.(mp3|wma)$') {
			$cTrackTotal++
		}
	}

	if ($dirSrc -match '(.*\\)')
		{
		$dirAlbum = $matches[1] + "$szAlbum"
		Write-Host "RenameAlbum $dirSrc ->"
		Write-Host "            $dirAlbum"
		MergeAlbum $dirSrc $dirAlbum $szAlbum 0 $cTrackTotal $fReadonly
		}
	else
		{
		Write-Host "RenameAlbum: malformed input"
		}
	}

# ---------------------------------------------------------------------------
#
# This function combines the two dirs of one album, 'Foo' and 'Foo Disc 2'.
# It only works when the first album already has the desired name.
#
# Input:
#   $dir1 = "$dirRoot\MusicAtoS\Joe Jackson\Live 1980-86"
#   $dir2 = "$dirRoot\MusicAtoS\Joe Jackson\Live 1980-86 (Disc 2)"
#   fReadonly = for real, or pretend?

function MergeAlbum_2ndInto1st
	{
	$dir1 = $args[0]
	$dir2 = $args[1]
	$fReadonly = $args[2]

	$cTrackTotal = 0
	foreach ($fileMusic in Get-ChildItem -LiteralPath $dir1) {
		if ($fileMusic -match '^\d\d\.? .*\.(mp3|wma)$') {
			$cTrackTotal++
		}
	}
	foreach ($fileMusic in Get-ChildItem -LiteralPath $dir2) {
		if ($fileMusic -match '^\d\d\.? .*\.(mp3|wma)$') {
			$cTrackTotal++
		}
	}

	$szAlbum = $dir1 -replace '.*\\',''
	$maxTrack = MergeAlbum $dir1 $dir1 $szAlbum 0 $fReadonly
	MergeAlbum $dir2 $dir1 $szAlbum $maxTrack $cTrackTotal $fReadonly
	}

# ---------------------------------------------------------------------------
#
# Input: $args[0] = directory to merge from ('\\kona\glerumrw\musicatos\Joey X\Rocking Album Disc 3')
#        $args[1] = directory to merge into ('\\kona\glerumrw\musicatos\Joey X\Rocking Album')
#        $args[2] = album name ('Rocking Album')
#        $args[3] = how much we add to the track numbers, to account for the
#                   previous directories of the same album.
#             X Disc 1     |        X Disc 2        |        X Disc 3
#         cTrackDelta = 0  |    cTrackDelta = 3     |    cTrackDelta = 5
#          01 1a.wma       | 01 2a.wma -> 04 2a.wma | 01 3a.wma -> 08 3a.wma
#          02 1b.wma       | 02 2b.wma -> 05 2b.wma | 02 3b.wma -> 09 3a.wma
#          03 1c.wma       |                        | 03 3c.wma -> 10 3a.wma
#        $args[4] = fReadonly.  Are we in read-only mode?
#
# Output: return maxTrack, the largest track number found on this album
#
# Move-Item allows -Literal, while Rename-Item does not
#
# REVIEW: This will fail in (at least) the following circumstance:
#   Album Foo Disc 1\abc.wma
#   Album Foo Disc 2\abc.wma
# Because they lack the number prefix, we will not call UpdateMusicFile on
# each abc.wma.  Instead, they'll be copied over in the subsequent Move-Item,
# one on top of the other.

function MergeAlbum {
	$dirSrc = $args[0]
	$dirDest = $args[1]
	$szAlbum = $args[2]
	$cTrackDelta = $args[3]
	$cTrackTotal = $args[4]
	$fReadonly = $args[5]

	Write-Host "MergeAlbum [$dirSrc] [$dirDest]"

	# This is kind of a hack, but I like it.  In this case, all we need is
	# the return value of $maxTrack.
	if ($dirSrc -eq $dirDest) {
		$fReadonly = $true
	}

	# If $dirSrc matches with $rgAlbumInclusion, then we do it.
	if ($rgAlbumInclusion) {
		#Write-Host "rgAlbumInclusion found"
		$fFoundIt = $false
		foreach ($szAlbumInclusion in $rgAlbumInclusion) {
			if ($dirSrc -match $szAlbumInclusion) {
				Write-Host "Inclusion: [$szAlbumInclusion]"
				$fFoundIt = $true
			}
		}
		if (!$fFoundIt) { return 0 }
	}

	# If $dirSrc matches with $rgAlbumExclusion, then we skip it.
	if ($rgAlbumExclusion) {
		#Write-Host "rgAlbumExclusion found"
		foreach ($szAlbumExclusion in $rgAlbumExclusion) {
			if ($dirSrc -match $szAlbumExclusion) {
				Write-Host "Exclusion: [$szAlbumExclusion]"
				return 0
			}
		}
	}

	# Create $dirDest ('Foo') if necessary.
	if (!(Test-Path -LiteralPath $dirDest)) {
		if (!$fReadonly) { New-Item -Path $dirDest -Type directory | Out-Null }
	}

	$maxTrack = 0
	foreach ($fileMusic in Get-ChildItem -LiteralPath $dirSrc) {
		# Get-ChildItem: -Include doesn't work with -LiteralPath, so do it manually.
		# Music files are
		#   '04 blah blah.wma'
		#   '01. foo bar.mp3' // \.? means to mach on zero or one dot.
		if ($fileMusic -match '^\d\d\.? .*\.(mp3|wma)$') {
			$iTrack = UpdateMusicFile $fileMusic.Fullname $szAlbum $cTrackDelta $cTrackTotal $fReadonly
			if ($iTrack -eq -1)
				{
				if ($fReadonly)	{
					Write-Host "ERROR: UpdateMusicFile returned error with [$dirSrc]."
				} else {
					Write-Host "ERROR: UpdateMusicFile returned error; bailing on [$dirSrc]."
					return 0
				}
			}
			if ($iTrack -gt $maxTrack) {
				$maxTrack = $iTrack
			}
		} else {
			if ($fVerbose) { Write-Host "WARNING: skip $fileMusic because it's not a properly number-named WMA/MP3 file" }
		}
	}

	if (!$fReadonly) {
		# Get-ChildItem -Exclude doesn't work with -LiteralPath.  So we explicitly 
		#   delete desktop.ini and thumbs.db, instead of just not copying them.
		if (Test-Path -PathType Leaf -LiteralPath $dirSrc\thumbs.db) { Remove-Item -LiteralPath $dirSrc\thumbs.db -Force }
		if (Test-Path -PathType Leaf -LiteralPath $dirSrc\desktop.ini) { Remove-Item -LiteralPath $dirSrc\desktop.ini -Force }
		Get-Childitem -Force -LiteralPath $dirSrc -Recurse | Move-Item -Dest $dirDest -Force
		Remove-Item -LiteralPath $dirSrc -Force
	}

	if ($fVerbose) { Write-Host "return maxTrack($maxTrack) + cTrackDelta($cTrackDelta)" }
	return $maxTrack + $cTrackDelta
}

# ---------------------------------------------------------------------------
#
# This func returns a hashtable of all the metadata of the (presumed music) file.
# We are getting everything from Stream=0, no other streams. They don't seem to matter.
#
# https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-hashtable?view=powershell-7.1
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables?view=powershell-7.1
#
# Metadata output. No tabs, all spaces. 
# We will presume that we never go over 100 Idx values, and have no VeryVeryLong Names.
#
# Note that we have files, such as 
#    Deep Purple\Days May Come And Days May Go\CD1 (2008 Edition Compilation)\01. Owed to 'g' (instrumental).mp3)
# where the Idx values do not consistently increase.  This one jumps from 23 to 25.
#
# Possible flavors:
# -----------------------------------------------------------------------------------
# *
# * Idx  Name                   Stream Language Type  Value
# * ---  ----                   ------ -------- ----  -----
# *   0  Duration                    0    0    QWORD  1764710000, 0x00000000692f5670
# *   1  Bitrate                     0    0    DWORD  329465, 0x000506f9
# *   2  Seekable                    0    0     BOOL  True
# *   3  Stridable                   0    0     BOOL  False
# *   7  Signature_Name              0    0   STRING  ""
# *  12  CurrentBitrate              0    0    DWORD  325301, 0x0004f6b5
# *  17  FileSize                    0    0    QWORD  7134929, 0x00000000006cded1
# *  22  Author                      0    0   STRING  "Eydie GormÚ"
# *  25  WM/MCDI                     0    0   BINARY  [292 bytes]
# *  33  WM/EncodingTime             0    0    QWORD  132636208523500000, 0x01d737edcd65d9e0
# *  34  WMFSDKVersion               0    0   STRING  "12.0.19041.906"
# // Here's a very long Name:
# *  40  ThisIsVeryVeryLongAndSoWhatHappens   0    0   STRING  "Banana"
# -----------------------------------------------------------------------------------
# 123456789 123456789 123456789 123456789 123456789 123456789 123456789


function GetMetadata {
	$fileMusic = $args[0]
	$fVerbose = $args[1]

	if ($fVerbose) { Write-Host "GetMetadata $args" }

	$metadata = @{}

	foreach ($line in & MetadataEdit.exe $fileMusic show 0)	{
		# John Entwistle 'Left For Live' has metadata where 'Name' has a trailing null!
		#   Bitrate0x00                0    0    DWORD  320000
		$chNull = [String](0x00 -as [char])
		$line = $line -replace $chNull,''
		if ($fVerbose) { Write-Host "line = [$line]" }

		if ($line -match '^\*+$') {
			if ($fVerbose) { Write-Host "Header1" }
		}
		elseif ($line -match '\* Idx  Name\s+Stream Language Type  Value') {
			#if ($fVerbose) { Write-Host "Header2" }
		}
		elseif ($line -match '\* ---  ----\s+------ -------- ----  -----') {
			#if ($fVerbose) { Write-Host "Header3" }
		}
		elseif ($line -match 'Could not open the file') {
			if ($fVerbose) { Write-Host "Could not open the file." }
		}
		elseif ($line -match '\*\s+ (\d+)  ([\w\/]+)\s+0    0\s+(\w+)  (.*)') {
			$iDx = $matches[1]
			$szName = $matches[2]
			$szType = $matches[3]
			$szValue = $matches[4]

			$metadata[$szName] = @{"iDx"=$iDx; "type"=$szType; "value"=$szValue}
			#if ($fVerbose) { Write-Host $metadata[$szName].iDx $szName $metadata[$szName].type $metadata[$szName].value }
		}
		else {
			throw "Bad metadata: " + $line
		}
	}
	return $metadata
}

# ---------------------------------------------------------------------------
#
# This func modifies the file in place, and then renames it (moves it) in place.
# No moving between directories!

# Input: $args[0] = file
#        $args[1] = album name
#        $args[2] = amount to bump the track number
#        $args[3] = cTrackTotal.  Count of songs in the entire multi-dir set.
#        $args[4] = fReadonly.  Are we in read-only mode?
# Output: no error: return (original) track number
#         if error, return -1
#
# We rename the file to update its track
#  - '03 foo.wma' -> '11 foo.wma'
#
# We update its contents with MetadataEdit.
#  - WM/Track
#       WMT_TYPE_STRING	"3"
#       WMT_TYPE_STRING	"06"
#       WMT_TYPE_STRING "02/09"
#       WMT_TYPE_STRING "1/23"
#		WMT_TYPE_DWORD	0x00000003
#  - WM/TrackNumber
#       WMT_TYPE_STRING "2"
#       WMT_TYPE_STRING "6/10"
#       WMT_TYPE_STRING "02/27"
#		WMT_TYPE_DWORD	0x00000002
#  - WM/PartOfSet
#       WMT_TYPE_STRING "1/1"
#       WMT_TYPE_STRING "3"
#       WMT_TYPE_STRING	"CD 2"
#  - WM/AlbumTitle
#		WMT_TYPE_STRING	"Emancipation [Disc 1]"
#		WMT_TYPE_STRING	"Hardwired: To Self-Destruct [3CD Deluxe Version] Disc 1"
#		WMT_TYPE_STRING	"Elko, Disc 2"
#		WMT_TYPE_STRING	"Moments Of Pleasure CD 1"
#		WMT_TYPE_STRING	"Transmission Impossible (Deluxe 4CD)"
#		WMT_TYPE_STRING	"No Thanks! - The '70s Punk Rebellion (Disc 1)"
#
# Of all these, Track '3/15' is the toughest. We'd want to update the demoninator of the 
# first disc files, and both numerator/denominator of subsequent files.  But we don't know the
# denominator, until we've processed all the files, counted them all. Perhaps this should be
# done through a dedicated Mongo script, to correct all of them.

# -------------------------------------------------
# TrackNumber and Track have a few variants
# *.mp3
#	It's always these two:
#		10989	WM/Track		WMT_TYPE_STRING
#		10989	WM/TrackNumber	WMT_TYPE_STRING
#	First flavor, count/total:
#		 6318	WM/Track		WMT_TYPE_STRING	5/10
#		 6318	WM/TrackNumber	WMT_TYPE_STRING	5/10
#	Second flavor, just a count:
#		 4671	WM/Track		WMT_TYPE_STRING	5
#		 4671	WM/TrackNumber	WMT_TYPE_STRING	5
#   These are 1-based: 01 Foo.mp3 has WM/TrackNumber = '01/14'
#
# *.wma:
#	Most have just
#		29614	WM/TrackNumber	WMT_TYPE_DWORD
#   These are 1-based: 01 Foo.wma has WM/TrackNumber = 0x01.
#	Some also have
#		 7502	WM/Track		WMT_TYPE_DWORD
#   These are 0-based: 09 Bar.wma has WM/Track = 0x08.
#   Fleetwood Mac\Fleetwood Mac [Expanded]06 Crystal.wma
#	  WMT_TYPE_DWORD	WM/Track		[0x00000005]
#	  WMT_TYPE_DWORD	WM/TrackNumber	[0x00000006]
#	A few have them as strings, always just a count (not count/total):
#		  190	WM/TrackNumber	WMT_TYPE_STRING
#		   90	WM/Track		WMT_TYPE_STRING
#   They are 1-based and 0-based in the same style as the DWORDs.

# When Metadataedit MODIFies an MP3 WM/Track, it will also MODIFY WM/TrackNumber, 
# and vice versa.  This is not true for WMA (whether DWORD or STRING);
# there they are separate and distinct.

function UpdateMusicFile
	{
	$fileMusic = $args[0]
	$szAlbum = $args[1]
	[int]$myDelta = $args[2]
	[int]$cTrackTotal = $args[3]
	$fReadonly = $args[4]

	[int]$iTrack = -1
	[int]$iTrackNew = -1
	[int]$iTrackExpected = -1 # What we expect the filename to look like: '03 banana.wma'
	[int]$iDxTrack = -1
	[int]$iDxTrackNumber = -1
	[int]$iType = -1

	# MetadataEdit constants for 'Attrib Type'
	$WMT_TYPE_DWORD = 0
	$WMT_TYPE_STRING = 1

	if ($fVerbose) { Write-Host "UpdateMusicFile $args" }

	# --------------------------------------------
	# Get the file extension; everything past the final dot.

    if ($fileMusic -match '.*\.(?<Extension>.+)') {
        $ext = $Matches.Extension
		#Write-Host "Extension = $ext"
    }
	else {
		throw "Can't figure out the file extension of " + $fileMusic
	}

	# --------------------------------------------
	# Update WM/AlbumTitle from 'Foo CD1' to 'Foo'

	$meta = GetMetadata $fileMusic $fVerbose
	$metaAlbumTitle = $meta['WM/AlbumTitle']
	$iDx = $metaAlbumTitle.iDx

	if ($metaAlbumTitle.value) {
		# MetaDataEdit <filename> modify <stream number> <attrib index> <attrib type> <attrib value> <attrib language>
		#if ($fVerbose) { Write-Host "iDx = $meta['WM/AlbumTitle'].iDx" }
		#if ($fVerbose) { Write-Host "iDx = $metaAlbumTitle.iDx" }
		#if ($fVerbose) { Write-Host "iDx = $iDx" }
		if ($fVerbose) { Write-Host "MetadataEdit.exe $fileMusic modify 0 $iDx $WMT_TYPE_STRING $szAlbum 0" }
		if (!$fReadonly) {          &MetadataEdit.exe $fileMusic modify 0 $iDx $WMT_TYPE_STRING $szAlbum 0 | Out-Null }
	}
	else {
		# MetaDataEdit <filename> set <stream number> <attrib name> <attrib type> <attrib value>
		Write-Host "UpdateMusicFile: can't find WM/AlbumTitle in $fileMusic, so we're creating it."
		if ($fVerbose) { Write-Host "MetadataEdit.exe $fileMusic set 0 WM/AlbumTitle $WMT_TYPE_STRING $szAlbum" }
		if (!$fReadonly) {          &MetadataEdit.exe $fileMusic set 0 WM/AlbumTitle $WMT_TYPE_STRING $szAlbum | Out-Null }
	}

	# --------------------------------------------
	# This is such horseshit!  
	# The following two blocks are for WM/Track and WM/TrackNumber. 
	# They are very similar. They should be totally diff-able.
	# The differences between them are few, but necessary. To wit:
	#   1. In mp3, updating WM/Track auto-updates WM/TrackNumber.
	#   2. In wma, WM/Track is 0-based. All else is 1-based.

	# --------------------------------------------
	# Update WM/Track

	# Reload the metadata
	$meta = GetMetadata $fileMusic $fVerbose
	$metaTrack = $meta['WM/Track']

	if ($metaTrack -ne $null) {

		switch ($ext) {
			'mp3' {
				if ($metaTrack.type -ne "STRING") {
					throw "MP3 has non-String WM/Track: " + $fileMusic
				}
				$iType = $WMT_TYPE_STRING

				# Is it one number ('5') or two ('5/10')?
				if ($metaTrack.value -match '(?<numOne>\d+)\/(?<numTwo>\d+)') {
					if ($fVerbose) { Write-Host "WM/Track value contains a slash:[" $metaTrack.value "]=[" $Matches.numOne "-slash-" $Matches.numTwo "]" }
					$iTrack = $Matches.numOne
					$iTrackNew = [int]$Matches.numOne + $myDelta
					$szTrackNew = "$iTrackNew/$cTrackTotal"
				} elseif ($metaTrack.value -match '(?<numOnly>\d+)') {
					if ($fVerbose) { Write-Host "WM/Track value has no slash:[" $metaTrack.value "]=[" $Matches.numOnly "]" }
					$iTrack = $Matches.numOnly
					$iTrackNew = [int]$Matches.numOnly + $myDelta
					$szTrackNew = "$iTrackNew"
				} else {
					throw "MP3 has bogus value for WM/Track: " + $fileMusic + ": " + $metaTrack.value
				}
				$iTrackExpected = $iTrack
			}

			'wma' {
				switch ($metaTrack.type) {
					'DWORD' {
						# 2, 0x00000002
						if ($fVerbose) { Write-Host "WM/Track has" $metaTrack.type "type:" $metaTrack.value }
						if ($metaTrack.value -match '(?<numOne>\d+), 0x\d+') {
							$iTrack = [int]$Matches.numOne
							$iTrackNew = $iTrack + $myDelta
							$iType = $WMT_TYPE_DWORD
						} else {
							throw "WMA has bogus format for DWORD value:" + $metaTrack.value
						}
					}
					'STRING' {
						if ($fVerbose) { Write-Host "WM/Track has" $metaTrack.type "type:" $metaTrack.value }
						$iTrack = $metaTrack.value
						$iTrackNew = [int]$metaTrack.value + $myDelta
						$iType = $WMT_TYPE_STRING
						$iTrackExpected = $iTrack
					}
					default {
						throw ("WMA has bogus WM/Track type: " + $metaTrack.type)
					}
				}
				# This is the goofy case: the WM/Track metadata (STRING or DWORD) is 0-based.
				$iTrackExpected = $iTrack + 1
				$szTrackNew = "$iTrackNew"
			}

			default { 
				if ($fVerbose) { Write-Host "Ignoring file " + $fileMusic }
			} 
		}

		# When we rename '03 foo.wma' to '14 foo.wma', this is '14'.
		$szTrackPrefixNew = "$iTrackNew"

		if ($fVerbose) { Write-Host "myDelta = $myDelta, iTrackNew = [$iTrackNew], szTrackNew = [$szTrackNew]" }

		if ($myDelta -gt 0)	{
			# MetaDataEdit <filename> modify <stream number> <attrib index> <attrib type> <attrib value> <attrib language>
			if ($fVerbose) { Write-Host "MetadataEdit.exe $fileMusic modify 0 $metaTrack.iDx $iType $szTrackNew 0" }
			if (!$fReadonly) {          &MetadataEdit.exe $fileMusic modify 0 $metaTrack.iDx $iType $szTrackNew 0 | Out-Null }
		}
	}

	# --------------------------------------------
	# Update WM/TrackNumber

	# Reload the metadata
	$meta = GetMetadata $fileMusic $fVerbose
	$metaTrack = $meta['WM/TrackNumber']

	if ($metaTrack -ne $null) {

		switch ($ext) {
			'mp3' {
				# There is nothing to do. When WM/Track is updated in an mp3, WM/TrackNumber gets done too.
			}

			'wma' {
				switch ($metaTrack.type) {
					'DWORD' {
						# 2, 0x00000002
						if ($fVerbose) { Write-Host "WM/TrackNumber has" $metaTrack.type "type:" $metaTrack.value }
						if ($metaTrack.value -match '(?<numOne>\d+), 0x\d+') {
							$iTrack = [int]$Matches.numOne
							$iTrackNew = $iTrack + $myDelta
							$iType = $WMT_TYPE_DWORD
						} else {
							throw "WMA has bogus format for DWORD value:" + $metaTrack.value
						}
					}
					'STRING' {
						if ($fVerbose) { Write-Host "WM/TrackNumber1 has" $metaTrack.type "type:" $metaTrack.value }
						# We have to convert the string "3" to the integer 3. The string actually has the doublequotes.
						$iTrack = [int]$metaTrack.value.Replace('"','')
						$iTrackNew = $iTrack + $myDelta
						$iType = $WMT_TYPE_STRING
					}
					default {
						throw ("WMA has bogus WM/TrackNumber type: " + $metaTrack.type)
					}
				}
				$iTrackExpected = $iTrack
				$szTrackNew = "$iTrackNew"
			}

			default { 
				if ($fVerbose) { Write-Host "Ignoring file " + $fileMusic }
			}
		}

		# When we rename '03 foo.wma' to '14 foo.wma', this is '14'.
		$szTrackPrefixNew = "$iTrackNew"

		# My hack to skip mp3, but keep formatting diff-able vs the WM/Track block, above.
		if ($ext -eq 'wma') {
			if ($fVerbose) { Write-Host "myDelta = $myDelta, iTrackNew = [$iTrackNew], szTrackNew = [$szTrackNew]" }

			if ($myDelta -gt 0)	{
				# MetaDataEdit <filename> modify <stream number> <attrib index> <attrib type> <attrib value> <attrib language>
				if ($fVerbose) { Write-Host "MetadataEdit.exe $fileMusic modify 0 $metaTrack.iDx $iType $szTrackNew 0" }
				if (!$fReadonly) {          &MetadataEdit.exe $fileMusic modify 0 $metaTrack.iDx $iType $szTrackNew 0 | Out-Null }
			}
		}
	}

	# --------------------------------------------
	# Rename the file
	
	# REVIEW: regexp fails in this case; we match on \200 instead of \01.
	#  01 \\kona\glerum\musicatos\Frank Zappa\200 Motels Disc 1\01 Semi-Fraudulent-Direct-From-Hollywood Overture.wma

	# wildcard, backslash, digits, an optional period, then a space
	#     Blondie\No Exit\11 Happy Dog.wma
	#     Deep Purple\Fireball\01. Fireball.mp3
	if ($fileMusic -match ".*\\(\d+)\.? ") {
		[int]$iTrackPrefix = $matches[1]
		$szTrackPrefix = $matches[1]
		if ($fVerbose) { Write-Host "iTrackPrefix = $iTrackPrefix, szTrackPrefix = $szTrackPrefix, szTrackPrefixNew = $szTrackPrefixNew" }

		# Confirm the filename matches what we found in the metadata
		#if ($iTrackPrefix -eq $iTrackExpected) {
			if ($myDelta -gt 0) {
				$fullNew = "$fileMusic" -replace "\\$szTrackPrefix\.? ", "\$szTrackPrefixNew "
				if ($fVerbose) { Write-Host "Move-Item -LiteralPath $fileMusic -Destination $fullNew" }
				if (!$fReadonly) { Move-Item -LiteralPath $fileMusic -Destination $fullNew }
			}
		#} else {
		#	Write-Host "ERROR file prefix [$iTrackPrefix] doesn't match metadata [$iTrack] in $fileMusic"
		#	return -1
		#}
	}
	else {
		Write-Host "ERROR doesn't start with two digits: $fileMusic"
		return -1
	}

	return $iTrack
}

# ---------------------------------------------------------------------------
#
# We want to strip out a string, from every file in a directory.
# This is both from the filename, and from the 'Title' metadata.
# 
# This program has no arguments passed in.  The calls are made in-line,
# to RegexMusicFile.  That way we can see the usage history, for reference,
# in particular of the regexs.
# 
# The regex argument is for what gets removed.  There is no option (as yet) to have
# it replaced with something else.
# 
# Pius Cheung\Bach_ Goldberg Variations, Bwv 988 (arr. for Solo Marimba)
# Lose 'Goldberg Variations_ ' from the filename
# 	01 - Goldberg Variations_ Aria.mp3
# 	02 - Goldberg Variations_ Variation 1 a 1 Clav_.mp3
# 	... 
# 	31 - Goldberg Variations_ Variation 30 a 1 Clav. Quodlibet.mp3
# 	32 - Goldberg Variations_ Aria da capo.mp3
# Lose 'Goldberg Variations: ' from the metadata
# 	*  22  Title  0    0   STRING  "Goldberg Variations: Aria"
# 	*  22  Title  0    0   STRING  "Goldberg Variations: Variation 1 a 1 Clav."
# 	...
# 	*  22  Title  0    0   STRING  "Goldberg Variations: Variation 30 a 1 Clav. Quodlibet"
# 	*  22  Title  0    0   STRING  "Goldberg Variations: Aria da capo"

function RegexMusicFile
	{
	$dirSrc = $args[0]
	$dirDst = $args[1]
	$regex = $args[2]

	Write-Host "------------------------------------"
	Write-Host "dir src: [$dirSrc]"
	Write-Host "dir dst: [$dirDst]"
	Write-Host "reg: [$regex]"

	# Create $dirDst if necessary.
	if (!(Test-Path -LiteralPath $dirDst))
		{
		if (!$fReadonly) { New-Item -Path $dirDst -Type directory | Out-Null }
		}

	foreach ($file in Get-ChildItem -LiteralPath $dirSrc)
		{
		$fileSrc = "$dirSrc\$file"
		$fileDst = "$dirDst\$file" -replace $regex, ''

		if ($fVerbose) {
			Write-Host "file src: [$fileSrc]"
			Write-Host "file dst: [$fileDst]"
		}

		if (!$fReadonly) { Copy-Item -LiteralPath $fileSrc -Destination $fileDst }

		# I do the MetadataEdit *read* of src, and the *write* of dst.
		# This is just so fReadOnly will work (where dst doesn't exist).
		foreach ($line in & MetadataEdit.exe $fileSrc show 0)
			{
			# Astonishingly, there's a NULL character (0) following the 'Name', in our case 'STRING'.
			# 	*  22  Title  0    0   STRING  "Kashmir (Live: O2 Arena, London - December 10, 2007)"
			#if ($fVerbose) { Write-Host "$line" }
			if ($line -match '(\d+)\s+(Title)(\0)\s+(\d+)\s+(\d+)\s+(STRING)\s+"(.+)"')
				{
				#$all = $matches[0]
				#Write-Host $all
				$idx = $matches[1]
				$szName = $matches[2]
				$chNull = $matches[3]
				$iStream = $matches[4]
				$iLanguage = $matches[5]
				$szType = $matches[6]
				$valueSrc = $matches[7]

				# Run the regex over $valueSrc.  We replace it with nothing.
				$valueDst = $valueSrc -replace $regex, ''

				if ($fVerbose) {
					Write-Host "meta src: [$valueSrc]"
					Write-Host "meta dst: [$valueDst]"
				}

				#if ($fVerbose) { Write-Host "MetadataEdit.exe $fileDst modify $iStream $idx $WMT_TYPE_STRING $valueDst 0" }
				if (!$fReadonly) { & MetadataEdit.exe $fileDst modify $iStream $idx $WMT_TYPE_STRING $valueDst 0 | Out-Null }
				}
			}
		}
	}

# ---------------------------------------------------------------------------
#
# End of Music.ps1
#
# ===========================================================================
