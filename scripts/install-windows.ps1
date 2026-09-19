<#
.SYNOPSIS
    Convenience wrapper around the official Claude Code native installer for Windows.

.DESCRIPTION
    Installs Claude Code natively on Windows using PowerShell.
    Run from a regular (non-Administrator) PowerShell prompt.

.PARAMETER Channel
    "latest" (default), "stable", or a specific version number such as "2.1.89".

.EXAMPLE
    .\install-windows.ps1
    .\install-windows.ps1 -Channel stable
    .\install-windows.ps1 -Channel 2.1.89
#>

param(
    [string]$Channel = "latest"
)

Write-Host "==> Installing Claude Code (channel/version: $Channel)"

if ($Channel -eq "latest") {
    irm https://claude.ai/install.ps1 | iex
} else {
    & ([scriptblock]::Create((irm https://claude.ai/install.ps1))) $Channel
}

Write-Host "==> Verifying installation"
$claude = Get-Command claude -ErrorAction SilentlyContinue
if ($claude) {
    claude --version
    Write-Host "==> Claude Code installed successfully. Run 'claude' inside any project to start a session."
} else {
    Write-Host "==> 'claude' was not found on PATH. Open a new terminal and try again,"
    Write-Host "    or see: https://code.claude.com/docs/en/troubleshoot-install"
}
