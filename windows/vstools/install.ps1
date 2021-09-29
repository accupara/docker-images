# Remove any previous choco logs so that its easier to read logs later
del C:\ProgramData\chocolatey\logs\chocolatey.log

# Install the ENTIRE 2019 build tools. Eats up at least 50 GB.
choco install -y visualstudio2019buildtools --package-parameters "--allWorkloads --includeRecommended --includeOptional"