@ECHO off
:welcome
cls
@ECHO off
echo                                   ����������������������������������������ͻ
echo                                   �            Noita Save Tool             �
echo                                   �             by HootzMcToke             �
echo                                   �         The time is currently:         �
echo                                   �		%time%		   �
echo                                   �         Please select an option        �
echo                                   ����������������������������������������͹
echo                                   �            1. Backup a Save            �
echo                                   �            2. Restore a Save           �
echo                                   �            3. Play Game                �
echo                                   �            4. Auto Restore             �
echo                                   �            5. Quit                     �
echo                                   ����������������������������������������ͼ
@ECHO OFF
CHOICE /N /C:12345 /M ""%1
IF ERRORLEVEL ==5 GOTO quit
IF ERRORLEVEL ==4 GOTO autorestore
IF ERRORLEVEL ==3 GOTO playnoita
IF ERRORLEVEL ==2 GOTO restoresave
IF ERRORLEVEL ==1 GOTO backupsave

:backupsave
@ECHO off
DIR /B %userprofile%\AppData\LocalLow\Nolla_Games_Noita\saves
SET /P name="Enter Name of Save: "
echo %name%
rmdir %userprofile%\AppData\LocalLow\Nolla_Games_Noita\saves\%name%\ /s /q
mkdir %userprofile%\AppData\LocalLow\Nolla_Games_Noita\saves\%name%\
xcopy %userprofile%\AppData\LocalLow\Nolla_Games_Noita\save00\*.* %userprofile%\AppData\LocalLow\Nolla_Games_Noita\saves\%name%\*.* /e /y /i
@ECHO Backup Complete
GOTO welcome

:restoresave
@ECHO OFF
DIR /B %userprofile%\AppData\LocalLow\Nolla_Games_Noita\saves
SET /P name="Enter Name of Save: "
@echo "%name%"
rmdir %userprofile%\AppData\LocalLow\Nolla_Games_Noita\save00 /s /q
mkdir %userprofile%\AppData\LocalLow\Nolla_Games_Noita\save00
xcopy %userprofile%\AppData\LocalLow\Nolla_Games_Noita\saves\%name%\*.* %userprofile%\AppData\LocalLow\Nolla_Games_Noita\save00\*.* /e /y /i
@ECHO Backup save restored!
GOTO welcome

:autorestore
DIR /B %userprofile%\AppData\LocalLow\Nolla_Games_Noita\saves
SET /P name="Enter Name of Save: "
goto autochecker

:autochecker
tasklist | findstr "noita.exe"
if %ERRORLEVEL% ==0 goto recheck
ECHO Restoring.
rmdir %userprofile%\AppData\LocalLow\Nolla_Games_Noita\save00 /s /q
mkdir %userprofile%\AppData\LocalLow\Nolla_Games_Noita\save00
xcopy %userprofile%\AppData\LocalLow\Nolla_Games_Noita\saves\%name%\*.* %userprofile%\AppData\LocalLow\Nolla_Games_Noita\save00\*.* /e /y /i
start steam://rungameid/881100
TIMEOUT /T 60
goto autochecker

:recheck
TIMEOUT /T 5 >nul
goto autochecker

:startGame
CHOICE /N /C YNM /M "Do you wish to start Noita? [Y/N]:"%1
IF ERRORLEVEL 3 GOTO welcome
IF ERRORLEVEL 2 GOTO quit
IF ERRORLEVEL 1 GOTO playnoita

:playnoita
ECHO Launching Noita 
start steam://rungameid/881100
@ECHO OFF
GOTO GameMonitor


:GameMonitor
@echo off
SETLOCAL EnableExtensions

set EXE=noita.exe

FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% goto ProcessFound

goto ProcessNotFound

:ProcessFound
echo %EXE% is running
goto GameMonitor
:ProcessNotFound
echo %EXE% is not running
goto welcome


:quit
ECHO See you soon!
pause 
EXIT 
