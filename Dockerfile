# escape=`

ARG BASE_TAG=py3_1709

FROM mback2k/windows-python:${BASE_TAG}

RUN net user Buildbot /add

SHELL ["cmd.exe", "/s", "/c"]

RUN C:\Program^ Files^ ^(x86^)\Microsoft^ Visual^ Studio\2017\BuildTools\Common7\Tools\VsDevCmd.bat && `
    python -m pip install Twisted[windows_platform]

RUN python -m pip install buildbot-worker

RUN mkdir C:\Buildbot
WORKDIR C:\Buildbot

USER Buildbot
ADD buildbot-worker.bat C:\ProgramData\buildbot-worker.bat

CMD ["cmd.exe", "/s", "/c", "C:\\ProgramData\\buildbot-worker.bat"]
