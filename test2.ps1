function ExtraFilesMatch
	{
	Write-Host "ExtraFilesMatch"
	# Get-ChildItem without -recurse needs the \* (contents, not container)
	$d1 = $args[0] + '\*'
	$d2 = $args[1] + '\*'
	Write-Host "dir1 = $d1"
	Write-Host "dir2 = $d2"
	Write-Host "end of ExtraFilesMatch"
	4
	}

"start of the program"

$d1 = "abc"
$d2 = "efg"

ExtraFilesMatch $d1 $d2

"call xy"
$ret = ExtraFilesMatch "x" "y"
"called xy, ret = $ret"

"call A"
if (ExtraFilesMatch $d1 $d2)
	{
	"Ret true A"
	}
"called A"

"end of the program"
