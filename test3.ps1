$ExtraFiles = @{}
#$ExtraFiles = @{"foo" = "bar"}
foreach ($f1 in Get-ChildItem -Path "\\kona\musichome\soundtrack\The Nutcracker- The Motion Picture Disc 1" -exclude *.wma,*.mp3,*.wav)
	{
	Write-Host $f1
	Write-Host $f1.Name
	$ExtraFiles[$f1.Name] = $f1
	}
"Here is ExtraFiles"
$ExtraFiles

"============================="

$DoubleHash = @{}
$DoubleHash.abc = @{}
#$DoubleHash[abc] = @{"foo" = "555"}
$DoubleHash.abc = @{"foo" = "012"}
$DoubleHash.abc = @{"efg" = "789"}
$DoubleHash.def = @{"foo" = "456"}
$DoubleHash.def = @{"efg" = "123"}
"Here is DoubleHash"
$DoubleHash
"Here is DoubleHash.abc"
$DoubleHash.abc
"=========================="

$temps = @{}
$temps.freezing = 32
$temps.boilng = 212
$temps.absoluteZero = -459.67
$temps.comfortable = 72
"here is temps"
$temps
