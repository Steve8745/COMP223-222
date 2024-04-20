@echo off
setlocal enabledelayedexpansion

:language
cls
echo.
echo 1. ����
echo 2. English
echo.
set /p lang=Ո�x��һ�N�Z��/Choose your language��1-2����
if '%lang%'=='1' goto menu_zh
if '%lang%'=='2' goto menu_en
goto language

:menu_zh
cls
echo.
echo 1. Ӌ��Ŀ䛴�С
echo 2. �@ȡĿ���Ϣ
echo 3. �����ַ���
echo 4. �����ļ�
echo 5. �˳�
echo.
set /p choice=Ո�x��һ���x헣�1-5����
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
echo �oЧ���x헣�Ոݔ��1-5֮�g�Ĕ��֡�
pause
goto menu_zh

:invalid_choice_en
echo Invalid option, please enter a number between 1-5.
pause
goto menu_en

:dir_size_zh
set "directory="
set /a "size=0"
set /p directory=Ոݔ��Ŀ�·�������磺C:\Windows����
if not exist "%directory%" (
    echo Ŀ䛲����ڡ�
    pause
    goto menu_zh
)
for /r "%directory%" %%A in (*) do (
    set /a size+=%%~zA
)
echo Ŀ䛴�С��%size% bytes
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
set /p directory=Ոݔ��Ŀ�·�������磺C:\Windows����
if not exist "%directory%" (
    echo Ŀ䛲����ڡ�
    pause
    goto menu_zh
)
for /r "%directory%" %%A in (*) do (
    set /a nfiles+=1
)
for /r "%directory%" %%A in (.) do (
    set /a ndirs+=1
)
echo �ļ�������%nfiles%
echo Ŀ䛔�����%ndirs%
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
set /p s=Ոݔ��Ҫ���ҵ��ַ��������磺error����
set /p file=Ոݔ��.txt�ļ��������磺C:\Users\steve\Documents\example.txt����
if not exist "%file%" (
    echo �ļ������ڡ�
    pause
    goto menu_zh
) else (
    findstr /n /c:"%s%" "%file%" >nul
    if errorlevel 1 (
        echo �ַ���δ�ҵ���
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
set /p directory=Ոݔ��Ŀ�·�������磺C:\Windows����
set /p pattern=Ոݔ���ļ���ģʽ�����磺*.log����
if not exist "%directory%" (
    echo Ŀ䛲����ڡ�
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
