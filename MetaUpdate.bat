@cls
@if [%verbose%]==[] echo off
rem %1 = filename
rem %2 = attrib name
rem %3 = attrib type (STRING or DWORD)
rem %4 = new value

if [%4]==[] echo Usage: %0 filename attribName attribType newValue & goto AllDone
if not exist %1 echo %1 not found & goto AllDone

if [%3]==[DWORD] (
	set _type=0
) else (
if [%3]==[STRING] (
	set _type=1
) else (
	echo Attrib type [%3] must be STRING or DWORD
	goto AllDone
)
)
echo AttribType is %_type%

echo Update [%1].[%2] with [%3] value [%4]

echo Do we have the attrib already?
metadataedit %1 show 0 | findstr /c:" %2 "
if not errorlevel 1 echo Attribute %2 not found & goto UpdateAttrib

rem ---------------------------------------------------------

:CreateAttrib

echo Create [%1] [%2] with [%3] value [%4]

metadataedit %1 add 0 %2 %_type% %4 0

goto AllDone

rem ---------------------------------------------------------

:UpdateAttrib

echo Update [%1] [%2] with [%3] value [%4]

rem What is the index?
metadataedit %1 show 0 | findstr /c:" %2 " | perl -p -e "s/\* +(\d+) +%2.*/set iDx=$1/" > %tmp%\_mu1.bat
if errorlevel 1 echo Attribute %2 not found & goto AllDone
call %tmp%\_mu1.bat

metadataedit %1 modify 0 %iDx% %_type% %4 0

:AllDone
