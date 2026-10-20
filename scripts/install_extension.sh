#!/usr/bin/env bash
# Installs the extension with the syntax highlighting of the ARM assembly of the course in VS Code, for the current
# user. Needs VS Code (install_vscode.sh of vscode-arm-syntax-docker). Set VSIX to install a local .vsix file instead of
# the latest release. Standalone: can be run in an Ubuntu / Debian host, and is also used by the BMDE Docker images.
set -Eeuo pipefail

REPO=URV-teacher/arm-syntax-vscode-extension
vsix="${VSIX:-}"
if [ -z "${vsix}" ]; then
  version="$(wget -qO- "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name"' | cut -d '"' -f 4)"
  version="${version#v}"
  vsix="/tmp/arm-syntax-vscode-extension-${version}.vsix"
  wget -q "https://github.com/${REPO}/releases/download/v${version}/arm-syntax-vscode-extension-${version}.vsix" \
    -O "${vsix}"
fi

code --install-extension "${vsix}" --force
