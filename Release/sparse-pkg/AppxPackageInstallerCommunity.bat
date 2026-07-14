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
echo "Welcome to use Appx Package Installer Community!"
if defined str2 (
echo "invalid Package, Please try again!"
)
set /p "str2=Enter your appx package to install (allowed .appx .msix .appxbundle .msixbundle) :"
goto retry
)else (
set "appxfile=%str%"
)
start AddAppxPackage.bat %appxfile%
