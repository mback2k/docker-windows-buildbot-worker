if exist %BASEDIR%\buildbot.tac goto upgrade

:create
%ComSpec% /c C:\Python\Scripts\buildslave.bat create-slave "%BASEDIR%" "%MASTERHOST%:%MASTERPORT%" "%SLAVENAME%" "%SLAVEPASS%"

goto clean

:upgrade
%ComSpec% /c C:\Python\Scripts\buildslave.bat upgrade-slave "%BASEDIR%"

goto clean

:clean
set MASTERHOST=
set MASTERPORT=
set SLAVENAME=
set SLAVEPASS=

goto run

:run
C:\Python\Scripts\twistd.exe -no -l - -y %BASEDIR%\buildbot.tac

exit /b %ERRORLEVEL%
