@echo
echo LOG START [RCLONE] %DATE:~5,2%월 %DATE:~-2%일 %TIME:~0,2%시 %TIME:~3,2%분 %TIME:~6,2%초

set SOURCE=D:\Source
set LOG=D:\Log

if NOT %1% == "" (
    SOURCE=%1%
)

if NOT %2% == "" (
    LOG=%2%
)

set yyyymmdd=%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%
set RCLONE_EXE_PATH=C:\rclone\rclone.exe
set RCLONE_SOURCE_PATH=SOURCE
set RCLONE_LOG_PATH=LOG
set RCLONE_REMOTE_PATH=backup:
set RCLONE_LOG_FILE=%RCLONE_LOG_PATH%rclone_log_%yyyymmdd%.txt

rem remove old log
forfiles /P %RCLONE_LOG_PATH% /m rclone_log*.txt /D -7 /C "cmd /c del @path"

rem execute rclone 
%RCLONE_EXE_PATH% sync %RCLONE_SOURCE_PATH% %RCLONE_REMOTE_PATH% --transfers 64 --log-file=%RCLONE_LOG_FILE% -vv

echo LOG END [RCLONE] %DATE:~5,2%월 %DATE:~-2%일 %TIME:~0,2%시 %TIME:~3,2%분 %TIME:~6,2%초