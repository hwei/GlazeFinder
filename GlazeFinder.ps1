<#
.SYNOPSIS
    Fuzzy finder window switcher for GlazeWM

.DESCRIPTION
    Find-GlazeWindow queries all windows from GlazeWM, displays them in fzf
    for fuzzy searching, and focuses the selected window and its workspace.

    The function displays windows in the format:
    [Workspace] | ProcessName | WindowTitle

    You can search by any of these fields using fuzzy matching.

.EXAMPLE
    Find-GlazeWindow
    Opens fzf to select and focus a window

.EXAMPLE
    gf
    Uses the alias to quickly switch windows

.NOTES
    Requires:
    - GlazeWM (https://github.com/glzr-io/glazewm)
    - fzf (https://github.com/junegunn/fzf)
    - PowerShell 5.0 or later

    Alias: gf

.LINK
    https://github.com/[your-username]/GlazeFinder
#>
function Find-GlazeWindow {
    [CmdletBinding()]
    param()

    # Set UTF-8 encoding for proper display of international characters
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $OutputEncoding = [System.Text.Encoding]::UTF8

    # Check PowerShell version
    if ($PSVersionTable.PSVersion.Major -lt 5) {
        Write-Error "PowerShell 5.0 or later is required. Current version: $($PSVersionTable.PSVersion)"
        return
    }

    # Check for GlazeWM
    if (-not (Get-Command glazewm -ErrorAction SilentlyContinue)) {
        Write-Error "GlazeWM is not installed or not in PATH.`nPlease install from: https://github.com/glzr-io/glazewm"
        return
    }

    # Check for fzf
    if (-not (Get-Command fzf -ErrorAction SilentlyContinue)) {
        Write-Error "fzf is not installed or not in PATH.`nPlease install from: https://github.com/junegunn/fzf`nQuick install: winget install fzf"
        return
    }

    # 1. Retrieve window and workspace data from GlazeWM
    try {
        $winRaw = glazewm query windows | Out-String
        $wsRaw = glazewm query workspaces | Out-String

        if ([string]::IsNullOrWhiteSpace($winRaw)) {
            Write-Host "No windows found. Make sure GlazeWM is running and has managed windows." -ForegroundColor Yellow
            return
        }

        $windows = ($winRaw | ConvertFrom-Json).data.windows
        $workspaces = ($wsRaw | ConvertFrom-Json).data.workspaces
    }
    catch {
        Write-Error "Failed to query GlazeWM. Is GlazeWM running?`nError: $_"
        return
    }

    # Validate data
    if (-not $windows -or $windows.Count -eq 0) {
        Write-Host "No windows found." -ForegroundColor Yellow
        return
    }

    # 2. Format window list for fzf
    # Format: [Workspace] | ProcessName | WindowTitle | WindowID
    $selection = $windows | ForEach-Object {
        $win = $_
        $wsName = "Unknown"

        # Find the workspace this window belongs to
        foreach ($ws in $workspaces) {
            if ($ws.childrenIds -contains $win.parentId -or $ws.id -eq $win.parentId) {
                $wsName = $ws.name
                break
            }
        }

        # Format: [Workspace] | ProcessName | WindowTitle | WindowID
        # The WindowID is hidden from search but preserved for focusing
        "[$wsName] | {0,-12} | {1} | {2}" -f $win.processName, $win.title, $win.id
    } | fzf --reverse `
            --header="Focus Window" `
            --delimiter='\|' `
            --with-nth="1..3"

    # 3. Parse selection and extract target workspace and window ID
    if (-not $selection) {
        # User cancelled (pressed ESC), exit silently
        return
    }

    $parts = $selection.Split('|')
    if ($parts.Count -lt 4) {
        Write-Error "Failed to parse window selection."
        return
    }

    $targetWs = $parts[0].Trim().Trim('[]')
    $targetId = $parts[3].Trim()

    if (-not $targetId) {
        Write-Error "Failed to extract window ID from selection."
        return
    }

    # 4. Focus the selected workspace and window
    try {
        if ($targetWs -ne "Unknown") {
            glazewm command focus --workspace $targetWs 2>&1 | Out-Null
        }
        glazewm command focus --container-id $targetId 2>&1 | Out-Null
    }
    catch {
        Write-Error "Failed to focus window: $_"
    }
}

Set-Alias gf Find-GlazeWindow