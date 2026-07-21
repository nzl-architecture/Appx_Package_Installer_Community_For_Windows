@echo off
setlocal enabledelayedexpansion
cd "%~dp0"
set block=0
set "str=%*"
:retry
if defined str2 (
set "str=%str2%"
)
set "upper="
for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    set "str=!str:%%A=%%A!"
)
set "upper=!str!"
echo %upper% | findstr /C:".MSIX" >nul
set msixMatch=!errorlevel!
echo %upper% | findstr /C:".APPX" >nul
set appxMatch=!errorlevel!
if !appxMatch!==0 (
    set block=1
)
if !msixMatch!==0 (
    set block=1
)
if !block!==0 (
echo "Welcome to use Appx Package Manager Community!"
if defined str2 (
echo "invalid Package, Please try again!"
)
if "%mode%"=="" (
echo "Mode 0: install appx package"
echo "Mode 1: uninstall appx package"
echo "Mode 2: show all appx packages were system-level installed"
echo "Mode 3: show all appx packages were per-user installed"
set /p "mode=Select a mode:"
)
)else (
set "appxfile=%str%"
set "mode="
)
if "%mode%"=="0" (
set /p "str2=Enter your appx package file location to install (allowed .appx .msix .appxbundle .msixbundle) :"
goto retry
)
if "%mode%"=="1" (
start RemoveAppxPackage.bat
    goto :eof
)
if "%mode%"=="2" (
    net session >nul 2>&1 || (powershell -NoP -C "Start-Process -FilePath 'cmd.exe' -ArgumentList '/c', 'dism', '-online','-Get-ProvisionedAppxPackages','&pause' -Verb RunAs" && exit)
    goto :eof
)
if "%mode%"=="3" (
powershell.exe -Command "get-appxpackage"
    pause
    goto :eof
)
if defined appxfile (
start AddAppxPackage.bat %appxfile%
) else (
    goto retry
)
