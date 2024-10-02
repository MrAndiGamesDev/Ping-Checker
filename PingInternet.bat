@echo off
setlocal enabledelayedexpansion

@REM SETTINGS FOR THE COLORS
set ESC=
set ERROR=%ESC%[91m[ERROR]%ESC%[0m
set SUCCESS=%ESC%[92m[SUCCESS]%ESC%[0m
set INFO=%ESC%[93m[INFO]%ESC%[0m
set INTERNETCHECKER=%ESC%[94m[CHECKING THE INTERNET CONNECTION]%ESC%[0m

@REM SETTINGS FOR THE PING CHECKER
set "speedduration=1"

@REM SETTINGS FOR THE PING TEST
set "pingamount=4"
set "total=5"

@REM SETTINGS FOR THE PROGRESS BAR
set "char=#"
set "empty= "

@REM SETTINGS FOR THE PING TEST
set "pinglist=google.com microsoft.com"

for /l %%i in (1,1,%total%) do (
    set /a "percent=%%i * 100 / %total%"
    set "progressbar="
    for /l %%j in (1,1,%total%) do (
        if %%j leq %%i (
            set "progressbar=!progressbar!%char%"
        ) else (
            set "progressbar=!progressbar!%empty%"
        )
    )
    cls
    echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    echo ::                                                           ::
    echo ::  ##     ## ########     ###    ##    ## ########  ####    ::
    echo ::  ###   ### ##     ##   ## ##   ###   ## ##     ##  ##     ::
    echo ::  #### #### ##     ##  ##   ##  ####  ## ##     ##  ##     ::
    echo ::  ## ### ## ########  ##     ## ## ## ## ##     ##  ##     ::
    echo ::  ##     ## ##   ##   ######### ##  #### ##     ##  ##     ::
    echo ::  ##     ## ##    ##  ##     ## ##   ### ##     ##  ##     ::
    echo ::  ##     ## ##     ## ##     ## ##    ## ########  ####    ::
    echo ::                                                           ::
    echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
    echo %INTERNETCHECKER% [!progressbar!] !percent!%%
    timeout /t %speedduration% /nobreak >nul
)

cls
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo ::                                                           ::
echo ::  ##     ## ########     ###    ##    ## ########  ####    ::
echo ::  ###   ### ##     ##   ## ##   ###   ## ##     ##  ##     ::
echo ::  #### #### ##     ##  ##   ##  ####  ## ##     ##  ##     ::
echo ::  ## ### ## ########  ##     ## ## ## ## ##     ##  ##     ::
echo ::  ##     ## ##   ##   ######### ##  #### ##     ##  ##     ::
echo ::  ##     ## ##    ##  ##     ## ##   ### ##     ##  ##     ::
echo ::  ##     ## ##     ## ##     ## ##    ## ########  ####    ::
echo ::                                                           ::
echo :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@REM CHECK IF THE INTERNET CONNECTION IS AVAILABLE
if %errorlevel% neq 0 (
    echo %ERROR% Internet connection is not available.
    pause
    exit
) else (
    echo %INFO% Internet connection is available.
    echo.
)

@REM Ping multiple websites for better reliability
for %%i in (%pinglist%) do (
    echo %INFO% Pinging %%i...
    ping -n %pingamount% %%i
    if !errorlevel! neq 0 (
        echo %ERROR% Failed to ping %%i
    ) else (
        echo %SUCCESS% Successfully pinged %%i
    )
    echo.
)

@REM Calculate and display average ping time
for %%i in (%pinglist%) do (
    set "total_ping=0"
    set "successful_pings=0"
    for /f "tokens=5 delims=ms" %%a in ('ping -n %pingamount% %%i ^| findstr "time="') do (
        set /a "total_ping+=%%a"
        set /a "successful_pings+=1"
    )
    if !successful_pings! gtr 0 (
        set /a "avg_ping=(total_ping * 100) / successful_pings"
        set /a "avg_ping_whole=avg_ping / 100"
        set /a "avg_ping_decimal=avg_ping %% 100"
        echo %INFO% Average ping time for %%i: !avg_ping_whole!.!avg_ping_decimal! ms
    ) else (
        echo %ERROR% Failed to calculate average ping time for %%i
    )
)

@REM And Done Successfully Pinged Servers
timeout /t 2 /nobreak >nul

echo.
echo %INFO% Average Ping Isn't Accurate lmao

@REM PAUSES THE SCRIPT
pause >nul
