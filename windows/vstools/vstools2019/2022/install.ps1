# Copyright (c) 2016-2023 Crave.io Inc. All rights reserved
# Remove any previous choco logs so that its easier to read logs later
del C:\ProgramData\chocolatey\logs\chocolatey.log

# Install the ENTIRE 2019 build tools. Eats up at least 60 GB. Takes more than an hour to complete. Give it that time and space.
choco install -y visualstudio2019community --execution-timeout 10800 --package-parameters "--allWorkloads --includeRecommended --includeOptional"

Write-Output "VSTools 2019 installed"
