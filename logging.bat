@echo off
setlocal EnableDelayedExpansion

rem Set the log file path
set "logFile=logging.csv"

rem Set the stop time to 20:00
set "stopTime=20:00"

rem Initialize the loop counter
set "loopCounter=1"

rem Delete old logging.csv if it exists
if exist "%logFile%" (
del "%logFile%"
)

:loop
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do (
  set "day=%%a"
  set "month=%%b"
  set "year=%%c"
)
rem Get the current time
for /f "tokens=1-2 delims=: " %%a in ('time /t') do (
  set "hour=%%a"
  set "minute=%%b"
)

rem Check if the current time is past the stop time
if %hour% GEQ 20 (
  echo Stopping logging process.
  goto :done
)

rem read CPU usage
set "cpu="
for /f "skip=1" %%p in ('wmic cpu get loadpercentage') do if not defined cpu set "cpu=%%p"

rem write to log file
echo !day!.!month!.!year!,!hour!:!minute!,%cpu% >> %logfile%

rem Wait for 10 s before running the loop again
ping -n 11 127.0.0.1 > nul

goto :loop

:done

rem run python file
python3.6 data_transformation.py

rem Done
echo Logging process stopped.