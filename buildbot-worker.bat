if exist %BASEDIR%\buildbot.tac goto upgrade

:create
%ComSpec% /c C:\Python\Scripts\buildbot-worker.bat create-worker "%BASEDIR%" "%MASTERHOST%:%MASTERPORT%" "%WORKERNAME%" "%WORKERPASS%"

goto clean

:upgrade
%ComSpec% /c C:\Python\Scripts\buildbot-worker.bat upgrade-worker "%BASEDIR%"

goto clean

:clean
set MASTERHOST=
set MASTERPORT=
set WORKERNAME=
set WORKERPASS=

goto run

:run
C:\Python\Scripts\twistd.exe -no -l - -y %BASEDIR%\buildbot.tac

exit /b %ERRORLEVEL%
