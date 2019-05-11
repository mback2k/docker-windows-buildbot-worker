if (Test-Path -Path (Join-Path ${env:BASEDIR} 'buildbot.tac')) {
	Write-Host 'Upgrading existing buildslave ...'
	& C:\Python\Scripts\buildslave.bat upgrade-slave "${env:BASEDIR}"
	Write-Host 'Upgraded existing buildslave.'
} else {
	Write-Host 'Creating new buildslave ...'
	& C:\Python\Scripts\buildslave.bat create-slave "${env:BASEDIR}" "${env:MASTERHOST}:${env:MASTERPORT}" "${env:SLAVENAME}" "${env:SLAVEPASS}"
	Write-Host 'Created new buildslave.'
}
