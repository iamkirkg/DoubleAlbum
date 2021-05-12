	$QExtraFiles = @{}
	$QExtraFiles.'one' = 'Qone'
	$QExtraFiles.'two' = "Qtwo"
	$QExtraFiles.'three' = "Qthree"

	$QExtraFiles.GetType()
		#  IsPublic IsSerial Name                                     BaseType
		#  -------- -------- ----                                     --------
		#  True     True     Hashtable                                System.Object

	$QExtraFiles.'one'.GetType()
		#  True     True     String                                   System.Object

	$QExtraFiles
		# Key   : two
		# Value : Qtwo
		# Name  : two
		# 
		# Key   : three
		# Value : Qthree
		# Name  : three
		# 
		# Key   : one
		# Value : Qone
		# Name  : one

	foreach ($obj in $QExtraFiles)
		{
		"GetType = " + $obj.GetType()
			# GetType = hashtable

		$obj.GetType()	
			#  IsPublic IsSerial Name                                     BaseType
			#  -------- -------- ----                                     --------
			#  True     True     Hashtable                                System.Object

		$obj
			# Key   : two
			# Value : Qtwo
			# Name  : two
			# 
			# Key   : three
			# Value : Qthree
			# Name  : three
			# 
			# Key   : one
			# Value : Qone
			# Name  : one
		}

	"==========================================="

	$ExtraFiles = @{}
	$ExtraFiles.'one' = @{f1 = 'OneF1'; f2 = 'OneF2'}
	$ExtraFiles.'two' = @{f1 = 'TwoF1'}
	$ExtraFiles.'three' = @{f2 = 'ThreeF2'}
	$ExtraFiles.GetType()
		# True     True     Hashtable                                System.Object
	$ExtraFiles
		# Key   : two
		# Value : {f1}
		# Name  : two
		# 
		# Key   : three
		# Value : {f2}
		# Name  : three
		# 
		# Key   : one
		# Value : {f2, f1}
		# Name  : one

	foreach ($obj in $ExtraFiles.GetEnumerator())
		{
		$obj
			# Key   : two		Key   : three		Key   : one
			# Value : {f1}		Value : {f2}		Value : {f2, f1}
			# Name  : two		Name  : three		Name  : one
		$obj.GetType()
			# True     True     DictionaryEntry                          System.ValueType
		$obj.Key
			# two				three				one
		$obj.Value
			# Key   : f1		Key   : f2			[Key   : f2    Key   : f1]
			# Value : TwoF1		Value : ThreeF2		[Value : OneF2 Value : OneF1]
			# Name  : f1		Name  : f2			[Name  : f2    Name  : f1]
		$obj.Name
			# two				three				one
		}

	$ExtraFiles.one.GetType()
		# True     True     Hashtable                                System.Object
	$ExtraFiles.one
		# Key   : f2
		# Value : OneF2
		# Name  : f2
		# 
		# Key   : f1
		# Value : OneF1
		# Name  : f1
	$ExtraFiles.two
		# Key   : f1
		# Value : TwoF1
		# Name  : f1
	$ExtraFiles."three"
		# Key   : f2
		# Value : ThreeF2
		# Name  : f2
	$ExtraFiles.one.f1.GetType()
		# True     True     String                                   System.Object
	$ExtraFiles.one.f1
		# OneF1
	$ExtraFiles.one.f2
		# OneF2
	$ExtraFiles.two.f1
		# TwoF1
	$ExtraFiles.three.f1 	# This doesn't exist
	$ExtraFiles.three.f2
		# ThreeF2

	$name = 'one'
	if ($ExtraFiles.$name) { Write-Host "found $name" }	else { Write-Host "did not find $name" }
	$name = 'tWo'
	if ($ExtraFiles.$name) { Write-Host "found $name" }	else { Write-Host "did not find $name" }
	$name = 'missing'
	if ($ExtraFiles.$name) { Write-Host "found $name" }	else { Write-Host "did not find $name" }

	#$name = one.f1 # The term 'one.f1' is not recognized as the name of a cmdlet, function, script file, or operable program.
	$name = "one.f1"
	if ($ExtraFiles.$name) { Write-Host "found $name" }	else { Write-Host "did not find $name" }
	$name = 'one.f1'
	if ($ExtraFiles.$name) { Write-Host "found $name" }	else { Write-Host "did not find $name" }
	$name = 'one'.'f1'
	if ($ExtraFiles.$name) { Write-Host "found $name" }	else { Write-Host "did not find $name" }
	if ($ExtraFiles.One.f1) { Write-Host "found One.f1" }	else { Write-Host "did not find One.f1" } # works
	if ($ExtraFiles.ONE.f1) { Write-Host "found ONE.f1" }	else { Write-Host "did not find ONE.f1" } # works
	if ($ExtraFiles."One.f1") { Write-Host "found One.f1" }	else { Write-Host "did not find One.f1" }

	$name = 'one.f2'
	if ($ExtraFiles.$name) { Write-Host "found $name" }	else { Write-Host "did not find $name" }
	$name = 'three.f1'
	if ($ExtraFiles.$name) { Write-Host "found $name" }	else { Write-Host "did not find $name" }
	$name = 'three.f2'
	if ($ExtraFiles.$name) { Write-Host "found $name" }	else { Write-Host "did not find $name" }

	$name = 'one'
	if ($ExtraFiles.ContainsKey($name)) { Write-Host "ContainsKey found $name" } else { Write-Host "ContainsKey did not find $name" }
	$name = 'missing'
	if ($ExtraFiles.ContainsKey($name)) { Write-Host "ContainsKey found $name" } else { Write-Host "ContainsKey did not find $name" }
	$name = 'one.f1'
	if ($ExtraFiles.ContainsKey($name)) { Write-Host "ContainsKey found $name" } else { Write-Host "ContainsKey did not find $name" }


#	Write-Host "-=-=-=-=-=-=-=-=-=-=-=-=-=-="
#	$obj = $ExtraFile.'one.jpg'
#	$obj.keys
#	$ExtraFile.'one.jpg'.f2
#	$ExtraFile.'two.jpg'.f1
#	$ExtraFile.'three.jpg'.f2
#	Write-Host "-=-=-=-=-=-=-=-=-=-=-=-=-=-="
	
#	foreach ($f1 in Get-ChildItem -Path $d1 -exclude *.wma,*.mp3,*.wav)
#		{
#		$name = $f1.Name
#		$fullname = $f1.FullName
#		Write-Host "f1.Name = $name, f1.FullName = $fullname"
#		$ExtraFiles.$name = @{f1 = $f1}
#		}

#	if ($ExtraFiles)
#		{
#		Write-Host "ExtraFiles = "
#		foreach ($obj in $ExtraFiles)
#			{
#			Write-Host "keys1 = " 
#			Write-Host $obj.keys #| format-list *
#			Write-Host "values1 = "
#			foreach ($obj2 in $obj.values)
#				{
#				Write-Host "keys2 = "
#				Write-Host $obj2.keys #| format-list *
#				Write-Host "values2 = "
#				Write-Host $obj2.values #| format-list *	
#				}
#			}
#		$ExtraFiles.Clear()
#		}
