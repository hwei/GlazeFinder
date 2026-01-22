<#
.SYNOPSIS
    Uninstallation script for GlazeFinder

.DESCRIPTION
    Removes GlazeFinder from your PowerShell profile and deletes the script file.

.EXAMPLE
    .\Uninstall.ps1
    Run the uninstallation
#>

[CmdletBinding()]
param()

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  GlazeFinder 卸载脚本" -ForegroundColor Cyan
Write-Host "  GlazeFinder Uninstallation Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$profileDir = Split-Path $PROFILE -Parent
$installPath = Join-Path $profileDir "GlazeFinder.ps1"

# Check if script exists
if (-not (Test-Path $installPath)) {
    Write-Host "  ✗ GlazeFinder.ps1 未找到 | Not found at: $installPath" -ForegroundColor Yellow
} else {
    Write-Host "删除脚本文件 | Removing script file..." -ForegroundColor Yellow
    Remove-Item $installPath -Force
    Write-Host "  ✓ 已删除 | Removed: $installPath" -ForegroundColor Green
}

Write-Host ""

# Remove from profile
if (-not (Test-Path $PROFILE)) {
    Write-Host "  ✗ PowerShell 配置文件不存在 | Profile does not exist" -ForegroundColor Yellow
} else {
    Write-Host "更新 PowerShell 配置 | Updating PowerShell profile..." -ForegroundColor Yellow

    $content = Get-Content $PROFILE -Raw
    $originalLength = $content.Length

    # Remove GlazeFinder lines
    $lines = Get-Content $PROFILE
    $newLines = @()
    $skip = $false

    foreach ($line in $lines) {
        # Skip GlazeFinder comment and the following source line
        if ($line -match '# GlazeFinder') {
            $skip = $true
            continue
        }
        if ($skip -and $line -match 'GlazeFinder\.ps1') {
            $skip = $false
            continue
        }
        if ($skip) {
            $skip = $false
        }
        $newLines += $line
    }

    # Remove trailing empty lines
    while ($newLines.Count -gt 0 -and [string]::IsNullOrWhiteSpace($newLines[-1])) {
        $newLines = $newLines[0..($newLines.Count - 2)]
    }

    if ($newLines.Count -eq 0) {
        # If profile is now empty, delete it
        Remove-Item $PROFILE -Force
        Write-Host "  ✓ 配置文件为空，已删除 | Profile empty, removed" -ForegroundColor Green
    } else {
        # Write back the cleaned content
        $newLines | Set-Content $PROFILE
        Write-Host "  ✓ 已从配置文件中移除 | Removed from profile" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ✓ 卸载完成！| Uninstallation complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "GlazeFinder 已从您的系统中移除。" -ForegroundColor White
Write-Host "GlazeFinder has been removed from your system." -ForegroundColor Gray
Write-Host ""
Write-Host "如需重新安装，请运行：" -ForegroundColor White
Write-Host "To reinstall, run:" -ForegroundColor Gray
Write-Host ""
Write-Host "  .\Install.ps1" -ForegroundColor Cyan
Write-Host ""
Write-Host "感谢使用 GlazeFinder！| Thank you for using GlazeFinder!" -ForegroundColor Green
Write-Host ""