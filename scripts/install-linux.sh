#!/usr/bin/env bash
#
# install-linux.sh
# Convenience wrapper around the official Claude Code native installer
# for Linux and WSL.
#
# Usage:
#   chmod +x install-linux.sh
#   ./install-linux.sh              # installs the latest channel
#   ./install-linux.sh stable       # installs the stable channel
#   ./install-linux.sh 2.1.89       # installs a specific version

set -euo pipefail

CHANNEL="${1:-latest}"

echo "==> Installing Claude Code (channel/version: ${CHANNEL})"

if [ "$CHANNEL" = "latest" ]; then
  curl -fsSL https://claude.ai/install.sh | bash
else
  curl -fsSL https://claude.ai/install.sh | bash -s "$CHANNEL"
fi

echo "==> Verifying installation"
if command -v claude >/dev/null 2>&1; then
  claude --version
  echo "==> Claude Code installed successfully. Run 'claude' inside any project to start a session."
else
  echo "==> 'claude' was not found on PATH. Open a new terminal and try again,"
  echo "    or see: https://code.claude.com/docs/en/troubleshoot-install"
fi
