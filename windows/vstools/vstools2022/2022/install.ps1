# Copyright (c) 2016-2025 Crave.io Inc. All rights reserved
# Remove any previous choco logs so that its easier to read logs later
if (Test-Path C:\ProgramData\chocolatey\logs\chocolatey.log) {
    Remove-Item C:\ProgramData\chocolatey\logs\chocolatey.log
}

# Install the ENTIRE 2022 build tools. Eats up at least 60 GB. Takes more than an hour to complete. Give it that time and space.
#choco install -y visualstudio2022buildtools --execution-timeout 7200 --package-parameters "--allWorkloads --includeRecommended --includeOptional"
choco install -y visualstudio2022community --execution-timeout 10800 --package-parameters "--allWorkloads --includeRecommended --includeOptional"

# Install the .NET SDK
echo a | choco install dotnet-sdk

Write-Output "VSTools 2022 installed"
