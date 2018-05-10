if not defined BASEDIR set BASEDIR=C:\Buildbot
if not defined MASTERHOST set MASTERHOST=master
if not defined MASTERPORT set MASTERPORT=10000
if not defined WORKERNAME set WORKERNAME=docker
if not defined WORKERPASS set WORKERPASS=docker

if exist %BASEDIR%\buildbot.tac goto upgrade

:create
cmd /c C:\Python\Scripts\buildbot-worker.exe create-worker "%BASEDIR%" "%MASTERHOST%:%MASTERPORT%" "%WORKERNAME%" "%WORKERPASS%"

goto clean

:upgrade
cmd /c C:\Python\Scripts\buildbot-worker.exe upgrade-worker "%BASEDIR%"

goto clean

:clean
set MASTERHOST=
set MASTERPORT=
set WORKERNAME=
set WORKERPASS=

goto info

:info

powershell -command Set-Content -Path (Join-Path %BASEDIR% 'info\admin') -Value (Get-WmiObject -Class Win32_ComputerSystem).Username
powershell -command Set-Content -Path (Join-Path %BASEDIR% 'info\host') -Value (Get-WmiObject -Class Win32_OperatingSystem).Caption

goto run

:run
C:\Python\Scripts\twistd.exe -no -l - -y %BASEDIR%\buildbot.tac

exit /b %ERRORLEVEL%
