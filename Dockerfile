# escape=`

ARG BASE_TAG=py3_1803

FROM mback2k/windows-python:${BASE_TAG}

RUN net user Buildbot /add

SHELL ["cmd.exe", "/s", "/c"]

RUN C:\Program^ Files^ ^(x86^)\Microsoft^ Visual^ Studio\2017\BuildTools\Common7\Tools\VsDevCmd.bat && `
    python -m pip install https://download.lfd.uci.edu/pythonlibs/t4jqbe6o/Twisted-19.2.1-cp36-cp36m-win_amd64.whl && `
    python -m pip install Twisted[windows_platform]

RUN python -m pip install buildbot-worker

RUN mkdir C:\Buildbot
WORKDIR C:\Buildbot

SHELL ["powershell", "-command"]

ENV BASEDIR=C:\Buildbot MASTERHOST=master MASTERPORT=10000 WORKERNAME=docker WORKERPASS=docker

ADD docker-entrypoint.d\01-buildbot-worker.ps1 C:\ProgramData\docker-entrypoint.d\
ADD docker-entrypoint.d\02-buildbot-info.ps1 C:\ProgramData\docker-entrypoint.d\

ENV DOCKER_ENV_HIDEVARS MASTERHOST MASTERPORT WORKERNAME WORKERPASS

CMD C:\\Python\\Scripts\\twistd.exe -noy ${env:BASEDIR}\\buildbot.tac
