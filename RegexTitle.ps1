<#
We want to strip out a string, from every file in a directory.
This is both from the filename, and from the 'Title' metadata.

This program has no arguments passed in.  The calls are made in-line,
to RegexMusicFile.  That way we can see the usage history, for reference,
in particular of the regexs.

The regex argument is for what gets removed.  There is no option (as yet) to have
it replaced with something else.

Pius Cheung\Bach_ Goldberg Variations, Bwv 988 (arr. for Solo Marimba)
Lose 'Goldberg Variations_ ' from the filename
	01 - Goldberg Variations_ Aria.mp3
	02 - Goldberg Variations_ Variation 1 a 1 Clav_.mp3
	03 - Goldberg Variations_ Variation 2 a 1 Clav_.mp3
	04 - Goldberg Variations_ Variation 3 a 1 Clav. Canone all' Unisuono.mp3
	... 
	30 - Goldberg Variations_ Variation 29 a 1 ovvero 2 Clav_.mp3
	31 - Goldberg Variations_ Variation 30 a 1 Clav. Quodlibet.mp3
	32 - Goldberg Variations_ Aria da capo.mp3
Lose 'Goldberg Variations: ' from the metadata
	*  22  Title  0    0   STRING  "Goldberg Variations: Aria"
	*  22  Title  0    0   STRING  "Goldberg Variations: Variation 1 a 1 Clav."
	*  22  Title  0    0   STRING  "Goldberg Variations: Variation 2 a 1 Clav."
	*  22  Title  0    0   STRING  "Goldberg Variations: Variation 3 a 1 Clav. Canone all' Unisuono"
	...
	*  22  Title  0    0   STRING  "Goldberg Variations: Variation 29 a 1 ovvero 2 Clav."
	*  22  Title  0    0   STRING  "Goldberg Variations: Variation 30 a 1 Clav. Quodlibet"
	*  22  Title  0    0   STRING  "Goldberg Variations: Aria da capo"

#>

# ===========================================================================
#
# Include common functions
#
# . .\Music.ps1
#
# ===========================================================================
#
# Process all the files in the directory.

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

# ===========================================================================
#
# The start of the program.

# MetadataEdit constants for 'Attrib Type'
$WMT_TYPE_DWORD = 0
$WMT_TYPE_STRING = 1

$fVerbose = $false
$fReadonly = $false

Write-Host "RegexTitle.ps1"

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
	}

# ===========================================================================
 
<#

# Led Zeppelin\Celebration Day
# Filename: lose ' (Live_ O2 Arena, London - December 10, 2007)'
# 	01 - Good Times Bad Times (Live_ O2 Arena, London - December 10, 2007).mp3
# 	02 - Ramble On (Live_ O2 Arena, London - December 10, 2007).mp3
# 	...
# 	15 - Whole Lotta Love (Live_ O2 Arena, London - December 10, 2007).mp3
# 	16 - Rock And Roll (Live_ O2 Arena, London - December 10, 2007).mp3
# Metadata: lose ' (Live: O2 Arena, London - December 10, 2007)'
# 	*  22  Title  0    0   STRING  "Good Times Bad Times (Live: O2 Arena, London - December 10, 2007)"
# 	*  22  Title  0    0   STRING  "Ramble On (Live: O2 Arena, London - December 10, 2007)"
# 	...
# 	*  22  Title  0    0   STRING  "Whole Lotta Love (Live: O2 Arena, London - December 10, 2007)"
# 	*  22  Title  0    0   STRING  "Rock And Roll (Live: O2 Arena, London - December 10, 2007)"

RegexMusicFile `
	"C:\Users\Kirk\Music\Amazon MP3\Led Zeppelin\Celebration Day" `
	"C:\Users\Kirk\Music\Amazon MP3\Led Zeppelin\Celebration Day.dst" `
	" \(Live[_:] O2 Arena, London - December 10, 2007\)"

RegexMusicFile `
	"C:\Users\Kirk\Music\Amazon MP3\Cannonball Adderley\Cannonball's Bossa Nova" `
	"C:\Users\Kirk\Music\Amazon MP3\Cannonball Adderley\Cannonball's Bossa Nova.dst" `
	" \(24Bit Mastering\)"

RegexMusicFile `
	"c:\Users\Kirk\Music\Amazon MP3\Frank Sinatra\Sinatra At The Sands [with Count Basie & His Orchestra]" `
	"c:\Users\Kirk\Music\Amazon MP3\Frank Sinatra\Sinatra At The Sands [with Count Basie & His Orchestra].dst" `
	" \[The Frank Sinatra Collection\] \[1966 Live At The Sands Album Version\]"

RegexMusicFile `
	"c:\Users\Kirk\Music\Amazon MP3\Pius Cheung\Bach_ Goldberg Variations, Bwv 988 (arr. for Solo Marimba)" `
	"c:\Users\Kirk\Music\Amazon MP3\Pius Cheung\Bach_ Goldberg Variations, Bwv 988 (arr. for Solo Marimba).dst" `
	"Goldberg Variations[_:] "

RegexMusicFile `
	"c:\Users\Kirk\Music\Amazon MP3\Thelonious Monk Quartet\At Carnegie Hall" `
	"c:\Users\Kirk\Music\Amazon MP3\Thelonious Monk Quartet\At Carnegie Hall.dst" `
	" \(Live At Carnegie Hall\)"

# "If You Can See Me [CD]"
# "I'll Take You There [*][CD]"
RegexMusicFile `
	"f:\Kirk\Music\David Bowie\The Next Day" `
	"f:\Kirk\Music\David Bowie\The Next Day.dst" `
	" \[.*\]"


# "09 - Uncle Harry's Last Freakout"
RegexMusicFile `
	"\\waikiki\glerumrw\Glerum Music\Pink Fairies\Never Neverland" `
	"\\waikiki\glerumrw\Glerum Music\Pink Fairies\Never Neverland.new" `
	"\d\d - "
#>

# ===========================================================================

# "Hold On [*][Single Version]"
RegexMusicFile `
	"\\waikiki\glerumrw\Glerum Music\Pink Fairies\(1973) Kings of Oblivion" `
	"\\waikiki\glerumrw\Glerum Music\Pink Fairies\Kings of Oblivion" `
	"\[.\]"
