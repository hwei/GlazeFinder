<#
.SYNOPSIS
    Installation script for GlazeFinder

.DESCRIPTION
    Installs GlazeFinder to your PowerShell profile and sets up the alias.
    Checks for dependencies and provides guidance if missing.

.PARAMETER Force
    Skip dependency checks and install anyway

.EXAMPLE
    .\Install.ps1
    Run interactive installation

.EXAMPLE
    .\Install.ps1 -Force
    Install without dependency checks
#>

[CmdletBinding()]
param(
    [Parameter()]
    [switch]$Force
)

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  GlazeFinder 安装脚本" -ForegroundColor Cyan
Write-Host "  GlazeFinder Installation Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check dependencies
Write-Host "检查依赖 | Checking dependencies..." -ForegroundColor Yellow
Write-Host ""

$dependencies = @{
    'glazewm' = 'https://github.com/glzr-io/glazewm'
    'fzf' = 'https://github.com/junegunn/fzf'
}

$missingDeps = @()
foreach ($dep in $dependencies.Keys) {
    Write-Host "  检查 $dep..." -NoNewline
    if (Get-Command $dep -ErrorAction SilentlyContinue) {
        Write-Host " ✓ 已安装 | Installed" -ForegroundColor Green
    } else {
        Write-Host " ✗ 未找到 | Not found" -ForegroundColor Red
        $missingDeps += $dep
    }
}

Write-Host ""

if ($missingDeps.Count -gt 0) {
    Write-Host "缺少以下依赖 | Missing dependencies:" -ForegroundColor Yellow
    Write-Host ""
    foreach ($dep in $missingDeps) {
        Write-Host "  ✗ $dep" -ForegroundColor Red
        Write-Host "    安装链接 | Install from: $($dependencies[$dep])" -ForegroundColor Gray

        if ($dep -eq 'fzf') {
            Write-Host "    快速安装 | Quick install: winget install fzf" -ForegroundColor Gray
        } elseif ($dep -eq 'glazewm') {
            Write-Host "    快速安装 | Quick install: winget install glzr-io.glazewm" -ForegroundColor Gray
        }
        Write-Host ""
    }

    if (-not $Force) {
        $continue = Read-Host "是否继续安装？Continue anyway? (y/N)"
        if ($continue -ne 'y' -and $continue -ne 'Y') {
            Write-Host ""
            Write-Host "安装已取消 | Installation cancelled." -ForegroundColor Yellow
            Write-Host ""
            exit
        }
    }
    Write-Host ""
}

# Get script path
$scriptPath = Join-Path $PSScriptRoot "GlazeFinder.ps1"

if (-not (Test-Path $scriptPath)) {
    Write-Error "找不到 GlazeFinder.ps1 文件 | Cannot find GlazeFinder.ps1"
    exit 1
}

# Create profile directory if it doesn't exist
$profileDir = Split-Path $PROFILE -Parent
if (-not (Test-Path $profileDir)) {
    Write-Host "创建 PowerShell 配置目录 | Creating PowerShell profile directory..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    Write-Host "  ✓ 已创建 | Created: $profileDir" -ForegroundColor Green
    Write-Host ""
}

# Copy script to profile directory
$installPath = Join-Path $profileDir "GlazeFinder.ps1"
Write-Host "复制脚本文件 | Copying script file..." -ForegroundColor Yellow
Copy-Item $scriptPath $installPath -Force
Write-Host "  ✓ 已复制到 | Copied to: $installPath" -ForegroundColor Green
Write-Host ""

# Update PowerShell profile
if (-not (Test-Path $PROFILE)) {
    Write-Host "创建 PowerShell 配置文件 | Creating PowerShell profile..." -ForegroundColor Yellow
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
    Write-Host "  ✓ 已创建 | Created: $PROFILE" -ForegroundColor Green
    Write-Host ""
}

$profileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
$sourceCommand = ". `"$installPath`""

if (-not $profileContent -or $profileContent -notmatch [regex]::Escape($sourceCommand)) {
    Write-Host "更新 PowerShell 配置 | Updating PowerShell profile..." -ForegroundColor Yellow

    # Add a newline if the file doesn't end with one
    if ($profileContent -and -not $profileContent.EndsWith("`n")) {
        Add-Content $PROFILE ""
    }

    Add-Content $PROFILE ""
    Add-Content $PROFILE "# GlazeFinder - Window switcher for GlazeWM"
    Add-Content $PROFILE $sourceCommand

    Write-Host "  ✓ 已添加到配置文件 | Added to profile: $PROFILE" -ForegroundColor Green
} else {
    Write-Host "  ✓ 配置文件中已存在 | Already exists in profile" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  ✓ 安装完成！| Installation complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "下一步 | Next steps:" -ForegroundColor Yellow
Write-Host ""
Write-Host "  1. 重启 PowerShell 或运行以下命令重新加载配置：" -ForegroundColor White
Write-Host "     Restart PowerShell or reload your profile:" -ForegroundColor Gray
Write-Host ""
Write-Host "     . `$PROFILE" -ForegroundColor Cyan
Write-Host ""
Write-Host "  2. 运行 GlazeFinder：" -ForegroundColor White
Write-Host "     Run GlazeFinder:" -ForegroundColor Gray
Write-Host ""
Write-Host "     gf" -ForegroundColor Cyan
Write-Host ""
Write-Host "  3. 查看帮助：" -ForegroundColor White
Write-Host "     Get help:" -ForegroundColor Gray
Write-Host ""
Write-Host "     Get-Help Find-GlazeWindow" -ForegroundColor Cyan
Write-Host ""
Write-Host "感谢使用 GlazeFinder！| Thank you for using GlazeFinder!" -ForegroundColor Green
Write-Host ""