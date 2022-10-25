# Copyright (c) 2016-2022 Crave.io Inc. All rights reserved
# Remove any previous choco logs so that its easier to read logs later
del C:\ProgramData\chocolatey\logs\chocolatey.log

Set-PSDebug -Trace 1

$BOOST_VER="1_80_0"
$BOOST_VER_DOTS=($BOOST_VER -replace '_', '.')

# Install the ENTIRE 2019 build tools. Eats up at least 60 GB. Takes more than an hour to complete. Give it that time and space.
choco install -y `
    7zip `
    cmake `
    mono `
    ninja `
    openjdk11 `
    python

# Find out the path to the JDK bin directory. This can be different every time we run this script. eg: "C:\Program Files\OpenJDK\openjdk-11.0.12_7\bin"
cd 'C:\Program Files\OpenJDK'
$JDK_BIN=Get-ChildItem -Recurse -Filter javac.exe | % { $_.FullName } | Split-Path -Parent

# Find out the path to the Python installation
cd C:\
$PYTHON_BIN=Get-ChildItem -Directory -Filter Python* | % { $_.FullName }

# Download and extract boost source
mkdir C:\libs
cd C:\libs
Invoke-WebRequest -OutFile C:\libs\boost_$BOOST_VER.tar.gz -Uri https://github.com/boostorg/boost/archive/refs/tags/boost-$BOOST_VER_DOTS.tar.gz
tar -xf C:\libs\boost_$BOOST_VER.tar.gz
mv boost-boost-$BOOST_VER_DOTS boost-$BOOST_VER_DOTS
$BOOST_ROOT="C:\libs\boost-$BOOST_VER_DOTS"
rm C:\libs\boost_$BOOST_VER.tar.gz

# Add tools to the PATH
Set-ItemProperty `
    -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' `
    -Name PATH `
    -Value ((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path `
         + ";C:\Program Files\Mono\bin" `
         + ";$JDK_BIN" `
         + ";$PYTHON_BIN")
# Remember the BOOST_ROOT
Set-ItemProperty `
    -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' `
    -Name BOOST_ROOT `
    -Value $BOOST_ROOT

Write-Output "Installed tools to build FoundationDB"
