echo off
cd /d "%~dp0"
net session >nul 2>&1
if NOT %errorlevel% == 0 (
    powershell -Win Hidden -NoP -ExecutionPolicy Bypass "try{Start-Process -Verb RunAs -FilePath '%~f0';exit}catch{}"
    exit
)
title Checking Python installation...
python --version > nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed! (Go to https://www.python.org/downloads and install the latest version.^)
    echo Make sure it is added to PATH.
    goto ERROR
)

title Checking libraries...

echo Checking 'colorama' (1/8)
python -c "import colorama" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing colorama...
    python -m pip install colorama > nul
)

echo Checking 'colorist' (2/8)
python -c "import colorist" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing colorist...
    python -m pip install colorist > nul
)

echo Checking 'datetime' (3/8)
python -c "import datetime" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing datetime...
    python -m pip install datetime > nul
)

echo Checking 'requests' (4/8)
python -c "import requests" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing requests...
    python -m pip install requests > nul
)

echo Checking 'tls-client' (5/8)
python -c "import tls_client" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing tls-client...
    python -m pip install tls-client > nul
)

echo Checking 'websocket-client' (6/8)
python -c "import websocket" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing websocket-client...
    python -m pip install websocket-client > nul
)

echo Checking 'uuid' (7/8)
python -c "import uuid" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing uuid...
    python -m pip install uuid > nul
)

echo Checking 'typing_extensions' (8/8)
python -c "import typing_extensions" > nul 2>&1
if %errorlevel% neq 0 (
    echo Installing typing_extensions...
    python -m pip install typing_extensions > nul
)
python main.py
if %errorlevel% neq 0 goto ERROR
exit
:ERROR
color 4 && title [Error]
pause > nul