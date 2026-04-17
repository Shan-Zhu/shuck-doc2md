@echo off
chcp 65001 >nul 2>&1
title Doc2MD 安装

echo ========================================
echo   Doc2MD - 右键菜单安装工具
echo ========================================
echo.

:: Get the directory where this bat file lives
set "SCRIPT_DIR=%~dp0"
set "EXE_PATH=%SCRIPT_DIR%doc2md.exe"

:: Check exe exists
if not exist "%EXE_PATH%" (
    echo [错误] 未找到 doc2md.exe
    echo 请确保 doc2md.exe 与此脚本在同一目录下。
    pause
    exit /b 1
)

:: Escape backslashes for reg file
set "EXE_REG=%EXE_PATH:\=\\%"

:: Write reg file with correct path
set "REG_FILE=%SCRIPT_DIR%_install_temp.reg"

echo Windows Registry Editor Version 5.00 > "%REG_FILE%"
echo. >> "%REG_FILE%"
echo [HKEY_CURRENT_USER\Software\Classes\SystemFileAssociations\.docx\shell\Doc2MD] >> "%REG_FILE%"
echo @="To Markdown" >> "%REG_FILE%"
echo. >> "%REG_FILE%"
echo [HKEY_CURRENT_USER\Software\Classes\SystemFileAssociations\.docx\shell\Doc2MD\command] >> "%REG_FILE%"
echo @="\"%EXE_REG%\" \"%%1\"" >> "%REG_FILE%"
echo. >> "%REG_FILE%"
echo [HKEY_CURRENT_USER\Software\Classes\SystemFileAssociations\.pdf\shell\Doc2MD] >> "%REG_FILE%"
echo @="To Markdown" >> "%REG_FILE%"
echo. >> "%REG_FILE%"
echo [HKEY_CURRENT_USER\Software\Classes\SystemFileAssociations\.pdf\shell\Doc2MD\command] >> "%REG_FILE%"
echo @="\"%EXE_REG%\" \"%%1\"" >> "%REG_FILE%"

:: Import registry
reg import "%REG_FILE%" >nul 2>&1

if %errorlevel% equ 0 (
    echo [成功] 右键菜单已安装！
    echo.
    echo 现在你可以右键点击 .docx 或 .pdf 文件，
    echo 选择 "To Markdown" 进行转换。
) else (
    echo [错误] 注册表导入失败，请右键以管理员身份运行。
)

:: Clean up
del "%REG_FILE%" >nul 2>&1

echo.
pause
