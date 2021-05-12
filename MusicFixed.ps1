<#

This is just an archive of previously-run commands,
from MusicFix.ps1.

It's not runnable.

#>

# =============================================================================================

<#

# -------
	$szAlbum = "Goodbye Yellow Brick Road"

	# Save this guy away (he's disc2, in the 'final' directory)
	$dirAlbum = "$dirRoot\MusicAtoS\Elton John\Goodbye Yellow Brick Road [Deluxe Edition] Disc 2"
	$dirDisc  = "$dirRoot\MusicAtoS\Elton John\Goodbye Yellow Brick Road"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum 0 $fReadonly

	$dirAlbum = "$dirRoot\MusicAtoS\Elton John\Goodbye Yellow Brick Road"
	$dirDisc  = "$dirRoot\MusicAtoS\Elton John\Goodbye Yellow Brick Road [Deluxe Edition] Disc 1"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum 0 $fReadonly
	$dirDisc  = "$dirRoot\MusicAtoS\Elton John\Goodbye Yellow Brick Road [Deluxe Edition] Disc 2"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $maxTrack $fReadonly
# -------
	$dirAlbum = "$dirRoot\MusicAtoS\G3\G3 Live"
	$szAlbum = $dirAlbum -replace '.*\\',''
	$dirDisc = "$dirRoot\MusicAtoS\Joe Satriani-Eric Johnson-Steve Vai\G3- Live in Concert"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum 0 $fReadonly
	$dirDisc = "$dirRoot\MusicAtoS\g3\G3 Live (Rockin' In The Free World) [UK] Disc 2"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $maxTrack $fReadonly
# -------
	$dirAlbum = "$dirRoot\MusicTtoZ\The Damned\Return to the 100 Club...April 18th 2007"
	$szAlbum = $dirAlbum -replace '.*\\',''
	$dirDisc = "$dirRoot\MusicTtoZ\The Damned\Return to the 100 Club...April 18th 2007 (Disc 1)"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum 0 $fReadonly
	$dirDisc = "$dirRoot\MusicTtoZ\The Damned\Return to the 100 Club...April 18th 2007 (Disc 2)"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $maxTrack $fReadonly
# -------
	$dirAlbum = "$dirRoot\MusicHome\Various Artists\Smithsonian Collection of Classic Jazz"
	$szAlbum = $dirAlbum -replace '.*\\',''
	$cTrackDelta = 0

	$dirDisc = "$dirRoot\MusicHome\Various Artists\Smithsonian Collection of Classic Jazz, Vol. 1 Disc 1"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $fReadonly
	$cTrackDelta = $cTrackDelta + $maxTrack
	$dirDisc = "$dirRoot\MusicHome\Various Artists\Smithsonian Collection of Classic Jazz, Vol. 2"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $fReadonly
	$cTrackDelta = $cTrackDelta + $maxTrack
	$dirDisc = "$dirRoot\MusicHome\Various Artists\Smithsonian Collection of Classic Jazz, Vol. 3"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $fReadonly
	$cTrackDelta = $cTrackDelta + $maxTrack
	$dirDisc = "$dirRoot\MusicHome\Various Artists\Smithsonian Collection of Classic Jazz, Vol. 4"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $fReadonly
	$cTrackDelta = $cTrackDelta + $maxTrack
	$dirDisc = "$dirRoot\MusicHome\Various Artists\Smithsonian Collection of Classic Jazz, Vol. 5"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $fReadonly
# --------------
	MergeAlbum_2ndInto1st `
	  "$dirRoot\MusicTtoZ\The Go-Go's\Return to the Valley of the Go-Go's" `
	  "$dirRoot\MusicTtoZ\The Go-Go's\Return to the Valley of the Go-Go's Disc 2" $fReadonly
	MergeAlbum_2ndInto1st `
	  "$dirRoot\MusicAtoS\Pete Townshend\Pete Townshend Live- A Benefit for Maryville Academy" `
	  "$dirRoot\MusicAtoS\Pete Townshend\Pete Townshend Live- A Benefit for Maryville Acadamy Disc 2" $fReadonly
	MergeAlbum_2ndInto1st `
	  "$dirRoot\MusicAtoS\Joe Jackson\Live 1980-86" `
	  "$dirRoot\MusicAtoS\Joe Jackson\Live 1980-86 (Disc 2)" $fReadonly
	MergeAlbum_2ndInto1st `
	  "$dirRoot\MusicHome\Various Artists\Disney's Princess Collection" `
	  "$dirRoot\MusicHome\Various Artists\Disney's Princess Collection, Vol. 2" $fReadonly
	MergeAlbum_2ndInto1st `
	  "$dirRoot\MusicAtoS\Soundtrack\Wicked" `
	  "$dirRoot\MusicAtoS\Soundtrack\Wicked- 5th Anniversary Special Edition [2 Discs] Disc 2" $fReadonly
	MergeAlbum_2ndInto1st `
	  "$dirRoot\MusicTtoZ\The Damned\Phantasmagoria" `
	  "$dirRoot\MusicTtoZ\The Damned\Phantasmagoria [Bonus CD] [Bonus Tracks] Disc 2" $fReadonly
	MergeAlbum_2ndInto1st `
	  "$dirRoot\MusicTtoZ\Yo-Yo Ma\Bach- Six Unaccompanied Cello Suites" `
	  "$dirRoot\MusicTtoZ\Yo-Yo Ma\Bach- Six Unaccompanied Cello Suites Disc 2" $fReadonly
# --------------
	RenameAlbum "$dirRoot\MusicAtoS\Brian James\Brian James Disc 2" `
	  "Brian James" $fReadonly
	RenameAlbum "$dirRoot\MusicAtoS\Elvis Costello & the Attractions\Blood & Chocolate Disc 1" `
	  "Blood & Chocolate" $fReadonly
	RenameAlbum "$dirRoot\MusicAtoS\Elvis Costello & The Imposters\The Delivery Man Disc 1" `
	  "The Delivery Man" $fReadonly
	RenameAlbum "$dirRoot\MusicAtoS\New York Dolls\One Day It Will Please Us to Remember Even This Disc 1" `
	  "One Day It Will Please Us to Remember Even This" $fReadonly
	RenameAlbum "$dirRoot\MusicAtoS\Stevie Ray Vaughan and Double Trouble\Hot in Hawaii Disc 1" `
	  "Hot in Hawaii" $fReadonly
	RenameAlbum "$dirRoot\MusicAtoS\T. Rex\Tanx [Expanded Edition] Disc 1" `
	  "Tanx" $fReadonly
	RenameAlbum "$dirRoot\MusicAtoS\T. Rex\The Slider [Expanded Edition] Disc 1" `
	  "The Slider" $fReadonly
	RenameAlbum "$dirRoot\MusicTtoZ\The Replacements\All for Nothing-Nothing for All Disc 2" `
	  "All for Nothing-Nothing for All" $fReadonly
	RenameAlbum "$dirRoot\MusicHome\Beck\The Information Disc 1" `
	  "The Information" $fReadonly
	RenameAlbum "$dirRoot\MusicHome\Phantom Planet\The Guest Disc 1" `
	  "The Guest" $fReadonly
	RenameAlbum "$dirRoot\MusicHome\Ricky Martin\Almas del Silencio Disc 1" `
	  "Almas del Silencio" $fReadonly
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
	$dirAlbum = "$dirRoot\MusicAtoS\Frank Zappa\Läther"
	$szAlbum = $dirAlbum -replace '.*\\',''

	$cTrackDelta = 0
	$dirDisc = "$dirRoot\MusicAtoS\Frank Zappa\Läther Disc 1"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $fReadonly

	$cTrackDelta = $cTrackDelta + $maxTrack
	$dirDisc = "$dirRoot\MusicAtoS\Frank Zappa\Läther Disc 2"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $fReadonly

	$cTrackDelta = $cTrackDelta + $maxTrack
	$dirDisc = "$dirRoot\MusicAtoS\Frank Zappa\Läther Disc 3"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $fReadonly
# -------
#	$dirAlbum = "$dirRoot\MusicAtoS\Frank Zappa\200 Motels"
#	$szAlbum = $dirAlbum -replace '.*\\',''
#
#	$cTrackDelta = 0
#	$dirDisc = "$dirRoot\MusicAtoS\Frank Zappa\200 Motels Disc 1"
#	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $fReadonly
#
#	$cTrackDelta = $cTrackDelta + $maxTrack
#	$dirDisc = "$dirRoot\MusicAtoS\Frank Zappa\200 Motels Disc 2"
#	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $fReadonly
# -------
# ---------------------------------------------------------------------------

RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Changestwobowie [EMI]" "Changestwobowie" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Diamond Dogs [Japan]" "Diamond Dogs" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Fame 90 [Rykodisc CD Single]" "Fame 90" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Heroes [Bonus Tracks]" "Heroes" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Hunky Dory [Bonus Tracks]" "Hunky Dory" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Lodger [Bonus Tracks]" "Lodger" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Low [Bonus Tracks]" "Low" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Pin Ups [Bonus Tracks]" "Pin Ups" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Scary Monsters [Bonus Tracks]" "Scary Monsters" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Space Oddity [Bonus Tracks]" "Space Oddity" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Station to Station [Bonus Tracks]" "Station to Station" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\The Man Who Sold the World [Bonus Tracks]" "The Man Who Sold the World" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Young Americans [Bonus Tracks]" "Young Americans" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Ziggy Stardust [Bonus Tracks]" "Ziggy Stardust" $fReadonly

RenameAlbum "$dirRoot\MusicAtoS\Aerosmith\Nine Lives [Clean]" "Nine Lives" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Aerosmith\Toys In The Attic [UK]" "Toys In The Attic" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Alice Cooper\Billion Dollar Babies [Deluxe Edition]" "Billion Dollar Babies" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Bauhaus\Burning from the Inside [Bonus Tracks]" "Burning from the Inside" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Bauhaus\In the Flat Field [Reissue]" "In the Flat Field" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Blind Faith\Blind Faith [2000 Deluxe Edition]" "Blind Faith" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Captain Sensible\The Masters [UK]" "The Masters" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Charlie Parker\The Best of the Bird [LaserLight]" "The Best of the Bird" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Danny Elfman\Batman [Original Score]" "Batman" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Danny Elfman\Mission Impossible [Score]" "Mission Impossible" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Danny Elfman\The Nightmare Before Christmas [2CD Reissue]" "The Nightmare Before Christmas" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Never Let Me Down [Japan Single]" "Never Let Me Down" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\David Bowie\Sound + Vision CD Single [TBCD 510]" "Sound + Vision CD Single" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Def Leppard\Hysteria [Deluxe Edition]" "Hysteria" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\Ella Fitzgerald\The Best of Ella Fitzgerald [Decca]" "The Best of Ella Fitzgerald" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Elton John\One Night Only [Bonus Tracks]" "One Night Only" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Elton John\Tumbleweed Connection [Bonus Tracks]" "Tumbleweed Connection" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Elvis Costello\Brutal Youth [Expanded]" "Brutal Youth" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Elvis Costello & the Attractions\Armed Forces [Ryko Bonus Tracks]" "Armed Forces" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Elvis Costello & the Attractions\Trust [Rhino Bonus Disc]" "Trust" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Frank Zappa\Chunga's Revenge [UK]" "Chunga's Revenge" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Frank Zappa\Shut Up 'N Play Yer Guitar [2 Disc]" "Shut Up 'N Play Yer Guitar" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\Freddie Mercury\Solo Collection [3 CD]" "Solo Collection" $fReadonly Disc 1
#RenameAlbum "$dirRoot\MusicAtoS\Freddie Mercury\Solo Collection [3 CD]" "Solo Collection" $fReadonly Disc 2
#RenameAlbum "$dirRoot\MusicAtoS\Freddie Mercury\Solo Collection [3 CD]" "Solo Collection" $fReadonly Disc 3
RenameAlbum "$dirRoot\MusicAtoS\Iggy & The Stooges\Open Up And Bleed [UK]" "Open Up And Bleed" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Iggy Pop\New Values [Bonus Tracks]" "New Values" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Iggy Pop\Party [Bonus Tracks]" "Party" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Iron Maiden\Best of the Beast [Bonus CD]" "Best of the Beast" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Iron Maiden\Somewhere in Time [Limited Edition]" "Somewhere in Time" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\jimi hendrix\The Jimi Hendrix Experience [MCA Box]" "The Jimi Hendrix Experience" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Jimi Hendrix Experience\Are You Experienced- [US 1993]" "Are You Experienced-" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Jimi Hendrix Experience\The Last Experience Concert- His Final Performance [1990]" "The Last Experience Concert- His Final Performance" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Joe Jackson\Steppin' Out- The Very Best of Joe Jackson [2001]" "Steppin' Out- The Very Best of Joe Jackson" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Johnny Cash\At San Quentin [The Complete 1969 Concert]" "At San Quentin" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Johnny Cash\Orange Blossom Special [Bonus Tracks]" "Orange Blossom Special" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\King Crimson\Discipline [30th Anniversary Edition] [Bonus Track]" "Discipline" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Marc Bolan\Zinc Alloy And The Hidden Riders Of Tomorrow [UK]" "Zinc Alloy And The Hidden Riders Of Tomorrow" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Mark Knopfler\Sailing to Philadelphia [Warner]" "Sailing to Philadelphia" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Mike Keneally\Hat [Expanded]" "Hat" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Miles Davis\The Complete Live At The Plugged Nickel 1965 [UK]" "The Complete Live At The Plugged Nickel 1965" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Mississippi Fred McDowell\I Do Not Play No Rock 'N' Roll [Bonus Tracks]" "I Do Not Play No Rock 'N' Roll" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Neil Young\Live at Massey Hall 1971 [CD-DVD]" "Live at Massey Hall 1971" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Neil Young and Crazy Horse\Live at the Fillmore East [CD-DVD]" "Live at the Fillmore East" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\New York Dolls\In NYC 1975 [UK]" "In NYC 1975" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Original Soundtrack\Singles [Original Soundtrack]" "Singles" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Original Soundtrack\The Rocky Horror Picture Show [Original Soundtrack]" "The Rocky Horror Picture Show" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Paul Westerberg\Open Season [Original Soundtrack]" "Open Season" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\Peter Gabriel\Peter Gabriel [1]" "Peter Gabriel" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\Peter Gabriel\Peter Gabriel [2]" "Peter Gabriel" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\Peter Gabriel\Peter Gabriel [3]" "Peter Gabriel" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Pink Floyd\The Dark Side of the Moon [SACD]" "The Dark Side of the Moon" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Queen\A Day at the Races [Bonus Tracks]" "A Day at the Races" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Queen\A Night at the Opera [Bonus Tracks]" "A Night at the Opera" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Queen\Hot Space [Bonus Track]" "Hot Space" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Queen\Jazz [Bonus Tracks]" "Jazz" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Queen\Live at Wembley '86 [1992]" "Live at Wembley '86" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Queen\Queen [Bonus Tracks]" "Queen" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Queen\Sheer Heart Attack [Bonus Track]" "Sheer Heart Attack" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\Red Hot Chili Peppers\Dani California [CD #2]" "Dani California" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Robert Johnson\The Complete Recordings [Columbia]" "The Complete Recordings" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Robert Plant\Dreamland [Bonus Tracks]" "Dreamland" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Robert Plant & The Honeydrippers\The Honeydrippers, Vol. 1 [Bonus Tracks]" "The Honeydrippers, Vol. 1" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Robyn Hitchcock\Black Snake Diamond Role [2007 Bonus Tracks]" "Black Snake Diamond Role" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Robyn Hitchcock & The Egyptians\Element of Light [Bonus Tracks]" "Element of Light" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Robyn Hitchcock & The Venus 3\Ole Tarantula [UK]" "Ole Tarantula" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Sisters of Mercy\Floodland [UK]" "Floodland" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Soundtrack\Little Shop of Horrors [2003 Original Cast]" "Little Shop of Horrors" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\Soundtrack\The Living Sea [Featuring the Music of Sting]" "The Living Sea" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\Sting\Demolition Man [#1]" "Demolition Man" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\Sting\I'm So Happy I Can't Stop Crying [US Single]" "I'm So Happy I Can't Stop Crying" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\Sting\Send Your Love [Australia CD]" "Send Your Love" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\Sting\You Still Touch Me [#2]" "You Still Touch Me" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\T. Rex\Electric Warrior [Expanded]" "Electric Warrior" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\T. Rex\T. Rex [Expanded Edition]" "T. Rex" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Talking Heads\Stop Making Sense [Special Edition]" "Stop Making Sense" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\The Beatles\Revolver [UK]" "Revolver" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\The Beatles\Rubber Soul [UK]" "Rubber Soul" $fReadonly
#RenameAlbum "$dirRoot\MusicAtoS\The Beatles\The Beatles [White Album]" "The Beatles" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\The Cramps\A Date With Elvis [Bonus Tracks]" "A Date With Elvis" $fReadonly

RenameAlbum "$dirRoot\MusicAtoS\Red Hot Chili Peppers\Dani California [CD #2]" "Dani California" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Sting\I'm So Happy I Can't Stop Crying [US Single]" "I'm So Happy I Can't Stop Crying" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Sting\Send Your Love [Australia CD]" "Send Your Love" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Sting\You Still Touch Me [#2]" "You Still Touch Me" $fReadonly

RenameAlbum "$dirRoot\MusicTtoZ\The Damned\Anything [Bonus CD] [Bonus Tracks]" "Anything [Bonus CD]" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Damned\Chaos Years- Rare & Unreleased 1977-1982 [Bonus Track]" "Chaos Years- Rare & Unreleased 1977-1982" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Damned\Damned Damned Damned [30th Anniversary Expanded Edition]" "Damned Damned Damned" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Damned\Eternally Damned (The Very Best Of The Damned) [UK]" "Eternally Damned (The Very Best Of The Damned)" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Damned\Machine Gun Etiquette [25th Anniversary Edition]" "Machine Gun Etiquette" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Damned\Strawberries [Deluxe Edition]" "Strawberries" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Damned\The Black Album [Deluxe Edition]" "The Black Album" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Kinks\Face to Face [UK Bonus Tracks]" "Face to Face" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Kinks\Low Budget [Bonus Tracks]" "Low Budget" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Kinks\Misfits [Velvel Bonus Tracks]" "Misfits" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Kinks\Muswell Hillbillies [UK]" "Muswell Hillbillies" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Kinks\To the Bone [US 2-CD]" "To the Bone" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Lords of the New Church\The Lords of the New Church [Bonus Tracks]" "The Lords of the New Church" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Pretenders\Pretenders II [Bonus Disc]" "Pretenders II" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Pretenders\The Pretenders [Bonus Disc]" "The Pretenders" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Who\Live at Leeds [1995 Remaster]" "Live at Leeds" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Who\Quick One (Happy Jack) [Bonus Tracks]" "Quick One (Happy Jack)" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Who\Tommy [MCA Double Disc Set]" "Tommy" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Who\Who's Next [Bonus Tracks]" "Who's Next" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\Tin Machine\Tin Machine II [Bonus Tracks]" "Tin Machine II" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\Tyrannosaurus Rex\Unicorn [Expanded Edition]" "Unicorn" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\U2\Please [US]" "Please" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\Van Halen\Live- Right Here, Right Now [CD]" "Live- Right Here, Right Now" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\Various Artists\Loud, Fast & Out of Control- The Wild Sounds of the '50s [Box]" "Loud, Fast & Out of Control- The Wild Sounds of the '50s" $fReadonly

RenameAlbum "$dirRoot\MusicHome\Original Soundtrack\The Sound of Music [30th Anniversary Soundtrack]" "The Sound of Music" $fReadonly
RenameAlbum "$dirRoot\MusicHome\Original Soundtrack\The Wizard of Oz [Rhino Original Soundtrack]" "The Wizard of Oz" $fReadonly
RenameAlbum "$dirRoot\MusicHome\Soundtrack\Aida [Orignal Broadway Cast]" "Aida" $fReadonly
RenameAlbum "$dirRoot\MusicHome\Soundtrack\Annie [Original Soundtrack & Story]" "Annie" $fReadonly
RenameAlbum "$dirRoot\MusicHome\Soundtrack\Beauty and the Beast [Disney Original Soundtrack]" "Beauty and the Beast" $fReadonly
RenameAlbum "$dirRoot\MusicHome\Soundtrack\Pippin [Original Broadway Cast]" "Pippin" $fReadonly
RenameAlbum "$dirRoot\MusicHome\Soundtrack\Rent [Original Broadway Cast]" "Rent" $fReadonly
RenameAlbum "$dirRoot\MusicHome\Soundtrack\South Pacific [2008 Broadway Cast]" "South Pacific" $fReadonly
RenameAlbum "$dirRoot\MusicHome\Soundtrack\The Lion King [Original Broadway Cast]" "The Lion King" $fReadonly

	MergeAlbum_2ndInto1st `
	  "$dirRoot\Peter Gabriel\Scratch My Back" `
	  "$dirRoot\Peter Gabriel\Scratch My Back Disc 2" $fReadonly

	$dirAlbum  = "$dirRoot\MusicAtoS\G3\Rockin' in the Free World"
	$szAlbum = $dirAlbum -replace '.*\\',''
	$dirDisc = "$dirRoot\MusicAtoS\Joe Satriani-Steve Vai-Yngwie Malmsteen\G3 Live- Rockin' in the Free World Disc 1"
	MergeAlbum $dirDisc $dirAlbum $szAlbum 0 $fReadonly
	$dirDisc = "$dirRoot\MusicAtoS\G3\Rockin2"
	MergeAlbum $dirDisc $dirAlbum $szAlbum 1 $fReadonly

RenameAlbum "$dirRoot\MusicAtoS\Bob Dylan\The Bootleg Series, Vol. 4- The 'Royal Albert Hall' Concert" "X" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Bob Dylan\X" "The Bootleg Series, Vol. 4- The 'Royal Albert Hall' Concert" $fReadonly

	$dirAlbum = "$dirRoot\\The Rolling Stones\\Exile on Main St. [2010]"
	$szAlbum = $dirAlbum -replace '.*\\',''

	$cTrackDelta = 0
	$dirDisc = "$dirRoot\\The Rolling Stones\\Exile on Main St. [Deluxe Edition] Disc 1"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $fReadonly

	$cTrackDelta = $cTrackDelta + $maxTrack
	$dirDisc = "$dirRoot\\The Rolling Stones\\Exile on Main St. [Deluxe Edition] Disc 2"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $cTrackDelta $fReadonly

RenameAlbum "$dirRoot\MusicAtoS\Lords of the New Church\Lords Prayer II Disc 1" "Lords Prayer II" $fReadonly
RenameAlbum "$dirRoot\MusicAtoS\Lords of the New Church\Lords Prayer II Disc 2" "Live at My Father's Place, New Jersey" $fReadonly
# This doesn't work, because the stupid thing has its Tracks listed as strings, not DWORDs.
#RenameAlbum "$dirRoot\MusicAtoS\Beatallica\Masterful Mystery Tour [Explicit]" "Masterful Mystery Tour" $fReadonly
RenameAlbum "$dirRoot\MusicTtoZ\The Damned\Anything [Bonus CD]" "Anything" $fReadonly

	$dirAlbum = "$dirRoot\MusicAtoS\Kate Bush\This Woman's Work"
	$szAlbum = $dirAlbum -replace '.*\\',''
	$dirDisc = "$dirRoot\MusicAtoS\Kate Bush\This Woman's Work, Vol. 1"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum 0 $fReadonly
	$dirDisc = "$dirRoot\MusicAtoS\Kate Bush\This Woman's Work, Vol. 2"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $maxTrack $fReadonly

	$dirAlbum = "$dirRoot\Luciano Pavarotti\The Definitive Collection"
	$szAlbum = $dirAlbum -replace '.*\\',''
	$dirDisc = "$dirRoot\Luciano Pavarotti\The Definitive Collection (2)"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum 0 $fReadonly
	$dirDisc = "$dirRoot\Luciano Pavarotti\The Definitive Pavarotti Collection A"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $maxTrack $fReadonly

	$dirAlbum = "$dirRoot\Original Cast Recording\The Phantom of the Opera"
	$szAlbum = $dirAlbum -replace '.*\\',''
	$dirDisc = "$dirRoot\Original Cast Recording\The Phantom of the Opera [Original London Cast] Disc 1"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum 0 $fReadonly
	$dirDisc = "$dirRoot\Original Cast Recording\The Phantom of the Opera [Original London Cast] Disc 2"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $maxTrack $fReadonly

	MergeAlbum_2ndInto1st `
	  "$dirRoot\The Rolling Stones\Some Girls" `
	  "$dirRoot\The Rolling Stones\Some Girls [Deluxe Edition] Disc 2" $fReadonly

RenameAlbum "$dirRoot\Iggy Pop\Roadkill Rising- The Bootleg Collection- 1977-2009 Disc 2" "Roadkill Rising - The Bootleg Collection; the '80s" $fReadonly
RenameAlbum "$dirRoot\Iggy Pop\Roadkill Rising- The Bootleg Collection- 1977-2009 Disc 3" "Roadkill Rising - The Bootleg Collection; the '90s" $fReadonly
RenameAlbum "$dirRoot\Iggy Pop\Roadkill Rising- The Bootleg Collection- 1977-2009 Disc 4" "Roadkill Rising - The Bootleg Collection; the '00s" $fReadonly
RenameAlbum "$dirRoot\Elvis Costello & the Imposters\Return of the Spectacular Spinning Songbook!!! [Limited Edition ] [CD-DVD-LP] [Super De Disc 1" "Return of the Spectacular Spinning Songbook!!!" $fReadonly

	$dirAlbum = "$dirRoot\Peter Gabriel\Live Blood"
	$szAlbum = $dirAlbum -replace '.*\\',''
	$dirDisc = "$dirRoot\Peter Gabriel\Live Blood Disc 1"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum 0 $fReadonly
	$dirDisc = "$dirRoot\Peter Gabriel\Live Blood Disc 2"
	$maxTrack = MergeAlbum $dirDisc $dirAlbum $szAlbum $maxTrack $fReadonly

RenameAlbum "$dirRoot\Paul Simon\So Beautiful Or So What Digital Booklet" "So Beautiful Or So What" $fReadonly

# ===========================================================================
# 
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

# ---------------------------------------------------------------------------

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

RenameAlbum "C:\Users\Kirk\Music\Amazon MP3\The Monkees\The Best Of The Monkees (US Release)" "The Best Of The Monkees" $fReadonly

RenameAlbum "C:\Users\Kirk\Music\Amazon MP3\Paul Simon\Graceland (Remastered 25th Anniversary Edition)" "Graceland" $fReadonly

RenameAlbum "C:\Users\Kirk\Music\Amazon MP3\Original Motion Picture Soundtrack\Chicago - Music From The Miramax Motion Picture" "Chicago" $fReadonly


RenameAlbum "f:\kirk\Music\Sting\Last Ship [LP]" "Last Ship" $fReadonly

MergeAlbum_2ndInto1st `
  "f:\kirk\Music\Sting\Last Ship" `
  "f:\kirk\Music\Sting\Last Ship [Bonus Disc] Disc 2" $fReadonly

#>

# =============================================================================================
