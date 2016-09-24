::File:Cmd_Cheat_Sheet.cmd v.1.2.8

:: GET A NICE PROMPT
set prompt=$P$S$S$t$_$_$S$S

:: forcely restart now
shutdown -r -f -t 00
:: forcely shutdown now
shutdown -s -f -t 00
:: forcely hibernate now
shutdown -h -f -t 00

C:\TEMP>"C:\TEMP\setup-x86_64.exe" -n -q -s ftp://lug.mtu.edu/cygwin -P ssh

C:\Users\A127036>RUNAS /profile /user:acc\\la-ext-yordan.georgi C:\Users\A127036\Downloads\setup-x86_64.exe -n -q -s ftp://lug.mtu.edu/cygwin -P ssh

RUNAS /profile /user:userName " shutdown.exe -r -f -m \\remoteHost" 

:: execute command remotely not working
LSrunas /user:userName /password:company01 /domain:%computername% /command:"reboot -r -f -m \\remoteHost" /runpath:"C:\Temp\prog\bin" 


psexec -u user001 -p pass "shutdown.exe -r -f -m \\RemoteHostName "
psexec -u user001 -p pass "shutdown.exe -r -f -m \\RemoteHostName"

LSrunas /user:userName /password:company01 /domain:%computername% /command:" updateTRN.bat \\AHostName" /runpath:"C:\Temp\ysg\bin"

:: ADDING USER WITH PASS
net user userName company01 /ADD 
:: ADDING USER TO THE LOCALGROUP ADMINISTRATORS 
net localgroup "Administrators" userName /add
:: ADDING username USER IDENTIFIED BY company01 TO THE LOCALGROUP ADMINISTRATORS 
net user username company01 /add
:: ADDING USER TO THE LOCALGROUP ADMINISTRATORS 
net localgroup "Administrators" username /add
:: OPENS THE EXPLORER IN THE C:\TEMP FOLDER MAXIMIZED - USE THE /MIN OPTION TO GET 

:: THE WINDOWS STARTED MINIMIZED
cmd /c start /max Explorer /e , "C:\Temp"
:: RUN THE REGEDIT AS A SPECIFIC USER 
RUNAS /profile /user:userName regedit | sanur /i C:\utils\psts.txt 

:: REboot agent remotely using the runas command - WORKS !!!!
:: START A CMD PROMPT UNDER THE userName user 
RUNAS /profile /user:userName cmd.exe | sanur /i C:\utils\psts.txt
RUNAS /profile /user:userName " shutdown.exe -f -r -t 00 -m \\RemoteHostName" 
::WORKS ALSO NEEDS SANUR http://www.commandline.co.uk/sanur_unsupported/index.html
RUNAS /profile /user:userName " shutdown.exe /f /r /t 00 /m \\2SGD00070" | sanur /i C:\utils\psts.txt

runas /u:domain\username program.exe | sanur /i C:\utils\psts.txt
:: GET ALL THE INFORMATION RELATED TO NETWORKING ON A WINDDOWS STATION 
ipconfig /all
:: USE OF FOR /F 
FOR /F "usebackq delims=\" %i IN (`DIR /AD /B`) DO FIND /I "TEMP"
:: LIST THE RUNNING APPLICATIONS
tasklist /v 
:: FIND SOMETHING IN A COMMMOR
ipconfig /all | find /i "Address"
:: EXPORT MOR PARSE VALUE FROM THE REGISTRY 
setlocal 
if exist tmp.reg del /q tmp.reg
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" tmp.reg
for /f "tokens=2 delims==" %%a in ('find /i "username" tmp.reg') do set line=%%a&call :strip
endlocal 
goto :EOF
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
:strip
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set usr=%line"=%
echo/the user is %usr%>>%computername%.txt
del /q tmp.reg 
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: ANOTHER WAY OF EXPORTING KEYS FROM THE REGISTRY
regedit /e c:\zzz\reg.reg "HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer" 

:: COUNT THE NUMBER OF SPECIFIC TYPE OF FILES ARE THEY IN A SPECIFIED DIRECTORY 
for /f "tokens=* delims=" %%i in ('dir C:\Temp\scripts\*.* /b /a-d ^| find /i /c "mdb"') do @echo num of scripts is %%i>>"%cd%\%computername%.txt" 

:: LABEL EACH FILE IN A DIRECTORY 
for /f "tokens=* delims=" %%i in ('dir /b C:\Temp\scripts\*.mdb') do @echo installed script %%i >>"%cd%\%computername%.txt" 

:: START EXPLORER 
for /f "tokens=* delims=" %%i in ('type DrillDownAllNames.txt') do (
) 
:: CHANGE DRIVE MOR DIRECTORY AT THE SAME TIME. 
cd /d %ProgramFiles% 
:: COMMMOR SEPERATOR. EXECUTES TWO (OR MORE) COMMMORS ON ONE LINE. 
dir & path 
SAME, BUT THE ECHO COMMMOR WILL ONLY BE EXECUTED WHEN THE COPY WAS SUCCESFUL. 
copy a b && echo 
SAME, ONLY IF UNSUCCESFUL. 
copy a b || goto error 

GOTO THE ERRORLABEL, IF THE PREVIOUS COMMMOR EXITTED WITH AN ERRORLEVEL BIGGER THAN ZERO. 
) 


:: HOW TO IMPORT SILENTLY A REGISTRY FROM A FILE 
reg import /s C:\temp\the_name_of_the_file.reg
reg import /s C:\temp\devrunpack\bin\PcAnyStealth.reg
:: ANOTHERWAYS TROUGH the regedit.exe
cmd /c %SystemRoot%\Regedit.exe /s thePaht\TheFile.reg 

:: HOW TO EXPORT VALUES FROM THE REGISTRY INTO A FILE

:: DELETING KEYS OR VALUES USING A REG FILE 
:: IT IS ALSO POSSIBLE TO DELETE KEYS MOR VALUES USING REG FILES. TO DELETE A KEY START BY :: USING THE SAME FORMAT AS THE THE REG FILE ABOVE, BUT PLACE A "-" SYMBOL IN FRONT OF THE :: :: KEY NAME YOU WANT TO DELETE. FOR EXAMPLE TO DELETE THE :: :: [HKEY_LOCAL_MACHINE\SYSTEM\SETUP] KEY THE REG FILE WOULD LOOK LIKE THIS: 

:: TO EXPORT A KNOW REGISTRY KEY FROM THE REGISTRY 
reg export "HKEY_LOCAL_MACHINE\SYSTEM\SETUP" filename.reg


:: IF A FILE OR FOLDER EXISTS (SPELLED WITHOUT THE LETTER S ON THE END). THE PARENTHESES 
:: GROUP THE COMMMORS OVER THE LINEBREAK (¶ DENOTES A LINEBREAK). 

if errorlevel 1 goto error 
if exist "file.log" 
echo Log exists
goto end
:: ESCAPE CHARACTER TO USE REDIRECT/PIPE CHARACTERS IS THE CARET (^) 
echo a -^> b 
:: REDIRECTS OUTPUT (INCLUDING ERROR MESSAGES) TO FILE.LOG 
command > file.log 2>&1 
:: COMMMOR SAME THING (BUT IT APPENDS). IN THIS WAY, YOUR BATCH FILES LOOK CLEANER. 
>> file.log 2>&1 
PUT MESSAGES IN STDIN.LOG MOR ERROR MESSAGES IN STDERR.LOG. 
command 1> stdin.log 2> stderr.log 

start /wait regedit /s file.reg 
:: Will ensure when the batch-file continues, the merge operation has completed. 
:: regsvr32 /s file.dll Registers a COM DLL without dialog boxes (no report via %errorlevel% of 
:: success/failure). Use /s /u for unregistering. :: QUIT'S THE CURRENT BATCH-FILE 
:: (ONLY WORKS UNDER NT4 WHEN COMMMOR EXTENTIONS ARE ENABLED, WHICH IS NOT THE DEFAULT). 
goto :EOF 
::THE BATCH FILE'S VERSION OF GOSUB. END THE "SUBROUTINE" WITH GOTO :EOF INSTEAD OF RETURN. 
ECHO LOG >> %~N0.LOG IN A BATCH FILF:\ TRICK TO APPEND A MESSAGE TO A LOG WITH THE SAME NAME AS THE BATCH-FILE, BUT WITH AN OTHER EXTENSION. 
call :subroutine 
notepad %* In a batch filF:\ replaced by all the arguments in a batch file.

C:\winnt\system32\drivers\etc\ 
147.243.4.137 servername


:: SEE THE CURRENT STATUS OF THE ACCOUNTS
net accounts


:: SET THE PASSWORDS TO NEVER EXPIRE ON THE LOCAL COMPUTER
net accounts /maxpwagF:\unlimited /%computername% 

:: ADDS LOCAL USER NO PASSWORD NOTHING DO NOT USE
net user userName secretPass /ADD /%computername%

NET USER userName company01 /ADD /expires: never /times: all /%computername% 


:: ADDS THE USERS TO THE ADMINISTRATOR GROUP 
net localgroup "Administrators" userName /add
net localgroup "Administrators" user001 /add


RUNAS /profile /user:user001 REGEDIT 
RUNAS /profile /user:userName REGEDIT



:: RUN CONSOLE ROOT
RUNAS /profile /user:userName mmc 
psexec -u userName -p company01 cmd /c regedit.exe 
psexec -u user001 -p secretPass cmd /c regedit.exe 

:: FIND MOR REPLACE STRING IN TEXT FILE USING GSAR 
gsar "-sIMMIDIATERUN:0611" "-rIMMIDIATERUN:0610" -o "C:\Temp\settings.txt" 

:: ACCESS EACH ROW FROM THE FILE
:: next_line_is_templatized
for /f "tokens=* delims=" %%a in ('morphuse/e +0 ^<"%cd%\%computername%.txt"') do 

:: COMPARING STRINGS
@echo off
set VAR=before
if "%VAR%" == "before" ( 
echo %var%
set VAR=after
echo %var%
pause
if "!VAR!" == "after" @echo If you see this, it worked 
)
echo %var%
pause
:: OPEN THE SERVICES FROM THE COMMMOR PROMPT
%SystemRoot%\system32\services.msc /s


:: THE USE OF THE SET COMMMOR 
set agent=something
:: WRONG !!!! AVOID SPACES BEFORE = AFTER IT MOR AFTER THE RVALUE IT TAKES THOSE ALSO !!!!!! 

::ALWAYS USE THE NET USE COMMMOR IF YOU WANT TO USE NETWORK RESOURCES FROM CMD
net use "\\server\share\" 

::USE REDIRECTING OF ERRORS THIS WAYS 
copy file1 file2 2> errors.txt
errors.txt


:: WE DO NOT WANT TO MESS WITH SCRIPTS
IF NOT DEFINED CMDWindow Set CMDWindow=1&Start "GetAndSendInfo" /MIN %0&Goto :EOF
:: PUT THE CODE HERE 
exit
:: append a new folder to the path of a 
AddPath -s -n -v Path "C:\Program Files\BEA Systems\TUXEDO"

:: DLL LINKING using the regsvr32 command SILENTLY
regsvr32 /s DIV_ExtMESClient.dll

:: runthe registry as a different user 
d

:: using runas command 
LSrunas /user:userName /password:company01 /domain:%computername% /command:"REGEDIT" /runpath:"%cd%"
:: normal 
RUNAS /profile /user:userName REGEDIT 

:: PSEXEC 
:: In order to get the psexec working the following commands should succeed
net use \\target\Admin$ /user:Administrator 
dir \\target\Admin$ 
net use \\target\Admin$ /delete 
:: (only disconnects, does not delete anything.) 

:: reboot fast station with the shutdown utility 
C:\Temp\ysg\bin\shutdown.exe -s reboot -f -m "The station will reboot in 3 seconds" -l 3 -c
shutdown -f -r -t 00

::========================================================= 
:: using bmail
::=========================================================
:: SETTING TO THE E-MAIL TO WHOM WE ARE GOING TO SEND THE E-MAIL
::=========================================================
set mailadd= yordan.georgiev^@company.com

::CONTCATENATE ANY ERRORS TO THE END OF THE LOG
echo errors in the logging process are listed bellow: >>"%cd%\%computername%.txt" 
:: next_line_is_templatized
for /f "delims=" %%a in ('morphuse/e +0 ^<"%cd%\error_log_%computername%.txt"') do echo/%%a>>"%cd%\%computername%.txt" 


:: WE USE THE BMAIL.EXE UTILITY TO SEND OURSELF AN E-MAIL CONTAINING THE TEXT FILE 
:: ALTERNATIVE SMTP MIGHT BE esebe107.NOE.company.com, UNCOMMENT THE NEXT LINE FOR ALTERN
:: cmd /c bmail -s esebe107.NOE.company.com -m %computername%.txt -t %mailadd% -a %computername% -h 
bmail -s smtp.company.com -m %computername%.txt -t yordan.georgiev^@company.com -a %computername% -h

:: eof using bmail
::=========================================================


::========================================================= 
:: edit the hosts file 
::========================================================= 
echo 147.243.4.137 serverName >> C:\winnt\system32\drivers\etc\hosts
::========================================================= 

::=======================================================
:: START A MINIMIZED BATCH WINDOW 
::======================================================= 
@echo off
IF NOT DEFINED CVRestart Set CVRestart=1&Start "Minimized" /MIN %0&Goto :EOF

exit
::=======================================================


::======================================================= 
:: USAGE OF THE WHERE COMMMOR ::WHERE [/R dir] [/Q] [/F] [/T] pattern...
::=======================================================
WHERE /R "\\server\share\" *spare*
::======================================================= 
::get the mac address of an workstatioin 
getMac


:: Start - Run utils 
:: Add or Remove Programs 
APPWIZ.CPL
:: COMPUTER MANAGEMENT 
COMPMGMT.MSC
:: DEVICE MANAGER
DEVMGMT.MSC 
:: DISK DEFRAGMENTER 
DFRG.MSC - 
:: Disk Management
DISKMGMT.MSC 
:: Event Viewer
EVENTVWR.MSC
:: Sound Volume 
SNDVOL.EXE

::Calculator 
CALC.EXE
::Character Map
CHARMAP.EXE
::Disk Space Cleanup Manager 
CLEANMGR.EXE
::SQL Client Configuration Utility
CLICONFG.EXE
::Clipboard Viewer
CLIPBRD.EXE
::Class Package Export Tool
CLSPACK.EXE
::Command Line 
CMD.EXE
::Connection Manager Profile Installer 
CMSTP.EXE
::Control Panel 
CONTROL.EXE
::Component Services
DCOMCNFG.EXE
::DDE 
DDESHARE.EXEShare
:: Doctor Watson v1.00b 
DRWATSON.EXE
:: Doctor Watson Settings 
DRWTSN32.EXE
:: DVD Player
DVDPLAY.EXE
:: DirectX Diagnostics 
DXDIAG.EXE
:: Private Character 
EUDCEDIT.EXEEditor
:: Event Viewer
EVENTVWR.EXE
:: Windows Explorer
EXPLORER.EXE
:: System Logoff
LOGOFF.EXE
:: Microsoft Management Console 
MMC.EXE
:: Remote Desktop Connection 
MSTSC.EXE /v 127.0.0.1:3388
:: Notepad 
NOTEPAD.EXE
:: NSLookup Application
NSLOOKUP.EXE
::Symbolic Debugger for Windows 2000 
NTSD.EXE
:: ODBC Data Source Administrator 
ODBCAD32.EXE
:: On Screen Keyboard
OSK.EXE
:: Windows Uninstall Utility
OSUNINST.EXE
:: Performance Monitor
PERFMON.EXE /RES 
:: Program Manager 
PROGMAN.EXE
:: Remote Access Phonebook 
RASPHONE.EXE
:: Registry Editor
REGEDIT.EXE
:: Resets Session 
RESET.EXE
:: System Restore
RSTRUI.EXE
:: RTC Application Sharing 
RTCSHARE.EXE
:: System File Checker
SFC.EXE
:: Create Shared Folder 
SHRPUBW.EXE
:: System Shutdown
SHUTDOWN.EXE
:: File Signature Verification 
SIGVERIF.EXE
:: Sound 
SNDREC32.EXERecorder
:: Display Properties
DESK.CPL
:: Add Hardware Wizard 
HDWWIZ.CPL
:: Internet Explorer Properties 
INETCPL.CPL
:: Regional and Language Options 
INTL.CPL
:: Mouse Properties
MAIN.CPL
:: Sounds and Audio Device Properties
MMSYS.CPL
:: Network Connections 
NCPA.CPL
:: User Accounts 
NUSRMGR.CPL
:: ODBC Data Source Administrator 
ODBCAD.CPL
:: Power Options Properties
POWERCFG.CPL
:: System Properties 
SYSDM.CPL
:: Phone and Modem Options
TELEPHON.CPL
:: Date and Time Properties 
TIMEDATE.CPL
:: Microsoft Management Console (MMC Snap-ins) - Certificates
CERTMGR.MSC 
:: Indexing Service
CIADV.MSC 
:: Shared Folders
FSMGMT.MSC 
:: Local Users and Groups 
LUSRMGR.MSC 
:: REMOVABLE STORAGE 
NTMSMGR.MSC
:: REMOVABLE STORAGE OPERATOR REQUESTS 
NTMSOPRQ.MSC 
:: PERFORMANCE MONITOR 
PERFMON.MSC
:: SERVICES
SERVICES.MSC 
:: WINDOWS MANAGEMENT INFRASTRUCTURE 
WMIMGMT.MSC 
:: CONVENTIONAL USER ACCOUNT INTERFACE 
CONTROL USERPASSWORDS2 
::START OFFICE APPLICATIONS FROM COMMMOR LINE 
EXCEL.EXE
MSACCESS.EXE 

MSPUB.EXE
:: Microsoft Office Picture Manager
OIS.EXE
OUTLOOK.EXE
POWERPNT.EXE
WINWORD.EXE

control keyboard 

RUNAS /profile /user:user001 "COMPMGMT.MSC " | sanur /i C:\utils\psts.txt 
RUNAS /profile /user:userName "regedit " | sanur company01 
:: STOP A SERVICE 
net stop "PCAnywhere Host Service" 

:: STOP AN WINDOWS SERVICE IN MICROSOFTS WAY 
sc \\servername stop schedule 
:: WITH PSINTERNALS 
psservice \\computername -u UserName-p Password stop "PCAnywhere Host Service" 
psservice \\RemoteHostName -u userName -p Password company01 stop "PCAnywhere Host Service" 



:: How do I concatenate files into one file overwriting previous existing one? 
copy /b /y *.txt APMDeployment.html

:: If you want separations between the files,
:: try something like this... 

@echo off
if .%1==.Loop goto process
> output.fil rem
for %%a in (*.txt) do call %0 Loop %%a 
goto end
:process
>>output.fil echo.
>>output.fil echo ----------- File %2 ----------- 
>>output.fil type %2
:end

net use \\hostName\Temp\tmp "secretPass" /USER: " yogeorgi@NOE.company.com"
NET USE W: \\hostName\Temp /Persistent:No 


:: COPY FILES RECURSIVELY TO THE CURRENT DIRECTORY 
:: USES exec.bat by Fred Stluka 
exec /s *pdrs*jpg do xcopy /s /m /f 

:: SETTING TITLE MOR COLOR MOR FOR CMD 
cmd.exe /k cd c:\Temp && color fc && title ***** Admin console ***** 

:: DELETE FILES CONTAINING STRING ON REMOTE COMPUTER 
:: uses srp.exe see start remote process 
cmd /c srp workstation cmd /c del /q C:\Temp\\*20060* 

:: Fast search the directory for filename 

::Windows fast directory search from WinLogo + R
cmd /c "dir C:\temp\path\*toFind* /s /b>list.txt&list.txt "

:: open all textpad files in a directory 
for /f "tokens=* delims=" %%i in ('dir /b /s c:\TEMP\OXIT\BATTERY\*.txt') do cmd /c start /max textpad %%i


:: the syntax of the if command 
echo set the variable to 0 
set variable=0
pause
IF %variable% == 0 (
::   commands to be executed if the condition is true 
echo the variable is %%variable%% = 0 
) ELSE (
echo the variable is %%variable%% = 1
::   commands to be executed if the condition is false
)
pause


:: PURPOSE 
:: TO PROVIDE THE USERS WITH COPY PASTE OF THE MOSTLY USED COMMMORS IN THE PECC TEAM
:: FOLLOW THE SYNTAX TO MAKE COPY PASTE EASIER , USE CAPITAL LETTERS FOR COMMENTS 

sleep for 3 seconds 
ping -n 3 127.0.0.1 >NULL

:: change the code page for UTF-8
chcp 65001

:: view advanced system properties from the command line 
sysdm.cpl

:: view to which ad groups a user belongs 
net user %username% /domain 

:: show history 
doskey /history 

#how-to install only specific package from cygwin via cmd
for /f "tokens=*" %i in ('echo bash binutils bzip2 cygwin gcc-core gcc-g++ gcc-java gzip m4 make unzip zip') do setup-x86_64.exe -n -q -s http://cygwin.mirror.constant.com -P %i

setup-x86_64.exe -n -q -s http://cygwin.mirror.constant.com -P %package%

:: how-to setup volume management via the keyboard 
:: create shortcut on the desktop with he following location 
%windir%\System32\SndVol.exe -f 49825268
:: assign some AltGrr + <<Key>> to it for example V, click Ok with the mouse 
:: press AltGr + V


::VersionHistory
:: 1.2.8 --- 2012-10-19 10:20:45 --- ysg --- clean up 
:: 1.2.8 --- ysg --- formatting cleaning 
:: 1.2.5 --- ysg --- removed NDA stuff