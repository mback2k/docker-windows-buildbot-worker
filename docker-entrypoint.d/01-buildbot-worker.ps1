if (Test-Path -Path (Join-Path ${env:BASEDIR} 'buildbot.tac')) {
	Write-Host 'Upgrading existing buildbot-worker ...'
	& C:\Python\Scripts\buildbot-worker.exe upgrade-worker "${env:BASEDIR}"
	Write-Host 'Upgraded existing buildbot-worker.'
} else {
	Write-Host 'Creating new buildbot-worker ...'
	& C:\Python\Scripts\buildbot-worker.exe create-worker "${env:BASEDIR}" "${env:MASTERHOST}:${env:MASTERPORT}" "${env:WORKERNAME}" "${env:WORKERPASS}"
	Write-Host 'Created new buildbot worker.'
}
