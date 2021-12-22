FROM microsoft/windowsservercore:1709
LABEL maintainer=bain@accupara.com description="accupara qt build container"


RUN @powershell -NoProfile -ExecutionPolicy Bypass -Command \
    $Env:chocolateyVersion = '0.10.8' ; \
    $Env:chocolateyUseWindowsCompression = 'false' ; \
    "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
RUN choco install openssh -y -params '"/SSHServerFeature"'
RUN sc delete sshd
RUN choco install -y rsync
RUN choco install -y visualstudio2017buildtools
RUN choco install -y visualstudio2017-workload-vctools
RUN choco install -y python && refreshenv && python --version 
RUN choco install -y strawberryperl && refreshenv && perl --version
RUN choco install -y git.install && refreshenv && git --version
RUN choco install -y jom && refreshenv && jom -version
RUN choco install -y visualstudio2017-workload-nativedesktop