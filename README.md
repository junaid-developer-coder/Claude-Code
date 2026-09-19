<img src="assets/20260919_070422.png" alt="Claude Code" width="600">


<div align="center">

# 🤖 Claude Code — Installation Guide

### Terminal-native AI coding agent by Anthropic — full setup for Linux and Windows

[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Windows%20%7C%20WSL-blue)](#)
[![Node](https://img.shields.io/badge/node-%3E%3D22-339933?logo=node.js&logoColor=white)](#)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Docs](https://img.shields.io/badge/docs-code.claude.com-orange)](https://code.claude.com/docs/en/installation)
[![Maintained](https://img.shields.io/badge/maintained-yes-brightgreen)](#)

</div>

---

## 📖 Overview

**Claude Code** is Anthropic's terminal-based AI coding agent. It reads your
repository, edits files, runs commands, and calls Claude directly from your
shell. This repository packages the **official installation steps** for
**Linux** and **Windows** into one place, with copy‑paste commands, ready‑to‑run
scripts, and a troubleshooting checklist.

> All commands below are sourced from Anthropic's official documentation at
> [code.claude.com/docs/en/installation](https://code.claude.com/docs/en/installation).
> Always prefer the official docs for the latest changes.

---

## 📋 System Requirements

| Requirement    | Details                                                              |
| -------------- | --------------------------------------------------------------------- |
| **OS**         | Windows 10 1809+/Server 2019+, Ubuntu 20.04+, Debian 10+, Alpine 3.19+ |
| **Hardware**   | 4 GB+ RAM, x64 or ARM64 processor                                     |
| **Network**    | Active internet connection                                            |
| **Shell**      | Bash, Zsh, PowerShell, or CMD                                         |
| **Account**    | Claude Pro, Max, Team, Enterprise, or Console (API key)               |

---

## 🐧 Installing on Linux (and WSL)

### Option 1 — Native install (recommended)

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

This installer auto-updates Claude Code in the background.

### Option 2 — Using this repo's helper script

```bash
chmod +x scripts/install-linux.sh
./scripts/install-linux.sh            # latest channel
./scripts/install-linux.sh stable     # stable channel
```

### Option 3 — Linux package managers

<details>
<summary><strong>apt (Debian / Ubuntu)</strong></summary>

```bash
sudo apt install curl gnupg
sudo install -d -m 0755 /etc/apt/keyrings
sudo curl -fsSL https://downloads.claude.ai/keys/claude-code.asc \
  -o /etc/apt/keyrings/claude-code.asc

echo "deb [signed-by=/etc/apt/keyrings/claude-code.asc] https://downloads.claude.ai/claude-code/apt/stable stable main" \
  | sudo tee /etc/apt/sources.list.d/claude-code.list
sudo apt update
sudo apt install claude-code
```

</details>

<details>
<summary><strong>dnf (Fedora / RHEL)</strong></summary>

```bash
sudo tee /etc/yum.repos.d/claude-code.repo <<'EOF'
[claude-code]
name=Claude Code
baseurl=https://downloads.claude.ai/claude-code/rpm/stable
enabled=1
gpgcheck=1
gpgkey=https://downloads.claude.ai/keys/claude-code.asc
EOF
sudo dnf install claude-code
```

</details>

<details>
<summary><strong>apk (Alpine Linux)</strong></summary>

Alpine needs `bash`, `curl`, `libgcc`, `libstdc++`, and `ripgrep` first:

```bash
apk add bash curl libgcc libstdc++ ripgrep
wget -O /etc/apk/keys/claude-code.rsa.pub \
  https://downloads.claude.ai/keys/claude-code.rsa.pub
echo "https://downloads.claude.ai/claude-code/apk/stable" >> /etc/apk/repositories
apk add claude-code
```

Then disable the bundled ripgrep in `~/.claude/settings.json`:

```json
{ "env": { "USE_BUILTIN_RIPGREP": "0" } }
```

</details>

### Option 4 — npm (global package)

Requires **Node.js 22+**.

```bash
npm install -g @anthropic-ai/claude-code
```

> ⚠️ Never run `sudo npm install -g` — it can cause permission and security issues.

---

## 🪟 Installing on Windows

You can run Claude Code **natively** or inside **WSL**. Pick based on your workflow:

| Option          | Requires             | Sandboxing | Best for                             |
| --------------- | --------------------- | ---------- | ------------------------------------- |
| Native Windows  | Nothing (Git optional) | Not supported | Windows-native projects & tools     |
| WSL 2           | WSL 2 enabled          | Supported  | Linux toolchains, sandboxed execution |

### Option 1 — Native Windows (PowerShell)

```powershell
irm https://claude.ai/install.ps1 | iex
```

### Option 2 — Native Windows (CMD)

```batch
curl -fsSL https://claude.ai/install.cmd -o install.cmd && install.cmd && del install.cmd
```

### Option 3 — Using this repo's helper script

```powershell
.\scripts\install-windows.ps1              # latest channel
.\scripts\install-windows.ps1 -Channel stable
```

### Option 4 — WinGet

```powershell
winget install Anthropic.ClaudeCode
```

> WinGet installs don't auto-update — run `winget upgrade Anthropic.ClaudeCode` periodically.

### Option 5 — Homebrew (via WSL) or WSL native install

Open your WSL distribution and run the Linux install command from the
[Linux section](#-installing-on-linux-and-wsl) above — install **inside** the
WSL terminal, not from PowerShell or CMD.

### 💡 Git for Windows (optional, recommended)

Installing [Git for Windows](https://git-scm.com/downloads/win) enables the
Bash tool via Git Bash. Without it, Claude Code falls back to the PowerShell
tool. If Claude Code can't auto-detect Git Bash, set it explicitly in
`settings.json`:

```json
{
  "env": {
    "CLAUDE_CODE_GIT_BASH_PATH": "C:\\Program Files\\Git\\bin\\bash.exe"
  }
}
```

---

## ✅ Verify Your Installation

```bash
claude --version
```

Expect output like `2.1.211 (Claude Code)`. For a full diagnostic:

```bash
claude doctor
```

---

## 🔐 Authenticate

Claude Code requires a **Pro, Max, Team, Enterprise, or Console** account
(the free claude.ai plan does not include Claude Code).

```bash
claude
```

Follow the browser prompt to log in. If `ANTHROPIC_API_KEY` is set in your
environment, Claude Code will ask you to approve using it instead.

---

## 🔄 Updating

| Install method            | Update behavior                                             |
| -------------------------- | ------------------------------------------------------------ |
| Native installer            | Auto-updates in the background                              |
| Homebrew                    | `brew upgrade claude-code`                                   |
| WinGet                      | `winget upgrade Anthropic.ClaudeCode`                        |
| apt / dnf / apk             | Standard system upgrade commands                             |
| npm                         | `npm install -g @anthropic-ai/claude-code@latest`             |

Force an immediate update on a native/npm install:

```bash
claude update
```

---

## 🗑️ Uninstalling

<details>
<summary><strong>Native installation (Linux/macOS/WSL)</strong></summary>

```bash
rm -f ~/.local/bin/claude
rm -rf ~/.local/share/claude
```

</details>

<details>
<summary><strong>Native installation (Windows PowerShell)</strong></summary>

```powershell
Remove-Item -Path "$env:USERPROFILE\.local\bin\claude.exe" -Force
Remove-Item -Path "$env:USERPROFILE\.local\share\claude" -Recurse -Force
```

</details>

<details>
<summary><strong>Remove all settings & session history</strong></summary>

```bash
rm -rf ~/.claude
rm ~/.claude.json
rm -rf .claude .mcp.json   # run inside a project directory
```

</details>

---

## 🛠️ Troubleshooting

- **`command not found` after install** → open a *new* terminal window, or check that `~/.local/bin` is on your `PATH`.
- **PowerShell vs CMD confusion** → your prompt shows `PS C:\` in PowerShell and plain `C:\` in CMD; each shell needs a different install command.
- **`403` or `syntax error near unexpected token '<'`** → see the official [Troubleshoot installation guide](https://code.claude.com/docs/en/troubleshoot-install).
- **Search/`ripgrep` failures on Alpine** → make sure `ripgrep` is installed and `USE_BUILTIN_RIPGREP` is set to `0`.
- **Permission errors on npm install** → never use `sudo`; fix npm's global directory permissions instead.

Full docs: **https://code.claude.com/docs/en/installation**

---

---

---

## 🙏 Credits

Installation steps sourced from Anthropic's official
[Claude Code documentation](https://code.claude.com/docs/en/installation).
