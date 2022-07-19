# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
FROM accupara/servercore:20H2

ADD install.ps1 /

RUN powershell.exe /install.ps1 -Wait

# Define the entry point for the docker container.
# This entry point starts the developer command prompt and launches the PowerShell shell.
# ENTRYPOINT ["C:/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/Common7/Tools/VsDevCmd.bat", "&&", "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]
