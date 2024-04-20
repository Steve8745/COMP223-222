@echo off
setlocal enabledelayedexpansion

:language
cls
echo.
echo 1. 中文
echo 2. English
echo.
set /p lang=請選擇一種語言/Choose your language（1-2）：
if '%lang%'=='1' goto menu_zh
if '%lang%'=='2' goto menu_en
goto language

:menu_zh
cls
echo.
echo 1. 計算目錄大小
echo 2. 獲取目錄信息
echo 3. 查找字符串
echo 4. 查找文件
echo 5. 退出
echo.
set /p choice=請選擇一個選項（1-5）：
if not '%choice%'=='' (
    if '%choice:~1%'=='' (
        if '%choice%'=='1' goto dir_size_zh
        if '%choice%'=='2' goto dir_info_zh
        if '%choice%'=='3' goto find_string_zh
        if '%choice%'=='4' goto find_files_zh
        if '%choice%'=='5' goto end
    )
)
goto invalid_choice_zh

:menu_en
cls
echo.
echo 1. Calculate directory size
echo 2. Get directory information
echo 3. Find string
echo 4. Find files
echo 5. Exit
echo.
set /p choice=Please choose an option (1-5):
if not '%choice%'=='' (
    if '%choice:~1%'=='' (
        if '%choice%'=='1' goto dir_size_en
        if '%choice%'=='2' goto dir_info_en
        if '%choice%'=='3' goto find_string_en
        if '%choice%'=='4' goto find_files_en
        if '%choice%'=='5' goto end
    )
)
goto invalid_choice_en

:invalid_choice_zh
echo 無效的選項，請輸入1-5之間的數字。
pause
goto menu_zh

:invalid_choice_en
echo Invalid option, please enter a number between 1-5.
pause
goto menu_en

:dir_size_zh
set "directory="
set /a "size=0"
set /p directory=請輸入目錄路徑（例如：C:\Windows）：
if not exist "%directory%" (
    echo 目錄不存在。
    pause
    goto menu_zh
)
for /r "%directory%" %%A in (*) do (
    set /a size+=%%~zA
)
echo 目錄大小：%size% bytes
pause
goto menu_zh

:dir_size_en
set "directory="
set /a "size=0"
set /p directory=Please enter the directory path (e.g., C:\Windows):
if not exist "%directory%" (
    echo Directory does not exist.
    pause
    goto menu_en
)
for /r "%directory%" %%A in (*) do (
    set /a size+=%%~zA
)
echo Directory size: %size% bytes
pause
goto menu_en

:dir_info_zh
set "directory="
set /a "nfiles=0"
set /a "ndirs=0"
set /p directory=請輸入目錄路徑（例如：C:\Windows）：
if not exist "%directory%" (
    echo 目錄不存在。
    pause
    goto menu_zh
)
for /r "%directory%" %%A in (*) do (
    set /a nfiles+=1
)
for /r "%directory%" %%A in (.) do (
    set /a ndirs+=1
)
echo 文件數量：%nfiles%
echo 目錄數量：%ndirs%
pause
goto menu_zh

:dir_info_en
set "directory="
set /a "nfiles=0"
set /a "ndirs=0"
set /p directory=Please enter the directory path (e.g., C:\Windows):
if not exist "%directory%" (
    echo Directory does not exist.
    pause
    goto menu_en
)
for /r "%directory%" %%A in (*) do (
    set /a nfiles+=1
)
for /r "%directory%" %%A in (.) do (
    set /a ndirs+=1
)
echo Number of files: %nfiles%
echo Number of directories: %ndirs%
pause
goto menu_en

:find_string_zh
set "s="
set "file="
set /p s=請輸入要查找的字符串（例如：error）：
set /p file=請輸入.txt文件名（例如：C:\Users\steve\Documents\example.txt）：
if not exist "%file%" (
    echo 文件不存在。
    pause
    goto menu_zh
) else (
    findstr /n /c:"%s%" "%file%" >nul
    if errorlevel 1 (
        echo 字符串未找到。
    ) else (
        findstr /n /c:"%s%" "%file%"
    )
)
pause
goto menu_zh

:find_string_en
set "s="
set "file="
set /p s=Please enter the string to find (e.g., error):
set /p file=Please enter the .txt file name (e.g., C:\Users\steve\Documents\example.txt):
if not exist "%file%" (
    echo File does not exist.
    pause
    goto menu_en
) else (
    findstr /n /c:"%s%" "%file%" >nul
    if errorlevel 1 (
        echo String not found.
    ) else (
        findstr /n /c:"%s%" "%file%"
    )
)
pause
goto menu_en

:find_files_zh
set "directory="
set "pattern="
set /p directory=請輸入目錄路徑（例如：C:\Windows）：
set /p pattern=請輸入文件名模式（例如：*.log）：
if not exist "%directory%" (
    echo 目錄不存在。
    pause
    goto menu_zh
) else (
    for /r "%directory%" %%A in (%pattern%) do (
        echo %%A
    )
)
pause
goto menu_zh

:find_files_en
set "directory="
set "pattern="
set /p directory=Please enter the directory path (e.g., C:\Windows):
set /p pattern=Please enter the file name pattern (e.g., *.log):
if not exist "%directory%" (
    echo Directory does not exist.
    pause
    goto menu_en
) else (
    for /r "%directory%" %%A in (%pattern%) do (
        echo %%A
    )
)
pause
goto menu_en

:end
endlocal
