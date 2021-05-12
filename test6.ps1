$dir = $args[0]

#$exe = "C:\Vmware\vcbMounter.exe"
#$host = "server"
#$user = "joe"
#$password = "cleartextpasswordsareanono:-)"
#$machine = "somepc"
#$location = "somelocation"
#$backupType = "incremental"
#
#& $exe -h $host -u $user -p $password -s "name:$machine" -r $location -t $backupType

& metadataedit.exe

$output = & metadataedit.exe
Write-Host "---------------"
Write-Host $output
Write-Host "================="

foreach ($line in & metadataedit.exe)
	{
	Write-Host "[ $line ]"
	}