@ECHO off
REM================================================================================
rem satisfactory savegame copy sync in dropbox
rem by Y. Lüdemann
rem V1.0.0 - 20 Mar 2020
rem copyright 2020
REM================================================================================

SET CWD=%~dp0

REM Main menu
:CHOICES
SET CURRENT_MENU=CHOICES
CLS
ECHO ----------------
ECHO Choose a option
ECHO ----------------
ECHO.
ECHO 1. save
ECHO 2. load
ECHO.
ECHO 99. Exit
ECHO.

REM Evaluate user input
SET /P choice=Choice: 
IF /I "%choice%" EQU "1"  GOTO :SAVECHOICE
IF /I "%choice%" EQU "2"  GOTO :LOADCHOICE
IF /I "%choice%" EQU "99"  GOTO :EXITCHOICE


:SAVECHOICE


FOR /F "delims=|" %%I IN ('DIR "%CWD%\*.sav" /B /O:D') DO SET NewestFile=%%I
del /f %NewestFile%

cd %appdata%\..\Local\FactoryGame\Saved\SaveGames\
Set "FirstDir="
For /d %%D in ("%appdata%\..\Local\FactoryGame\Saved\SaveGames\*") do If not defined FirstDir Set "FirstDir=%%D"
PushD "%FirstDir%"
Echo current dir = %CD%

FOR /F "delims=|" %%I IN ('DIR "%FirstDir%\*.sav" /B /O:D') DO SET NewestFile=%%I
copy "%FirstDir%\%NewestFile%" "%CWD%"

cd %CWD%
ECHO state saved
pause
GOTO :CHOICES

:LOADCHOICE

cd %appdata%\..\Local\FactoryGame\Saved\SaveGames\
Set "FirstDir="
For /d %%D in ("%appdata%\..\Local\FactoryGame\Saved\SaveGames\*") do If not defined FirstDir Set "FirstDir=%%D"

cd %CWD%


FOR /F "delims=|" %%I IN ('DIR "%CWD%\*.sav" /B /O:D') DO SET NewestFile=%%I
copy /Y "%CWD%\%NewestFile%" "%FirstDir%"

ECHO state loaded
pause
GOTO :CHOICES


:EXITCHOICE
