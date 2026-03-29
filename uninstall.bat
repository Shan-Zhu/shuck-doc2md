@echo off
chcp 65001 >nul 2>&1
title Doc2MD 卸载

echo ========================================
echo   Doc2MD - 右键菜单卸载工具
echo ========================================
echo.

reg delete "HKEY_CURRENT_USER\Software\Classes\SystemFileAssociations\.docx\shell\Doc2MD" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Classes\SystemFileAssociations\.pdf\shell\Doc2MD" /f >nul 2>&1

echo [成功] 右键菜单已卸载。
echo.
pause
