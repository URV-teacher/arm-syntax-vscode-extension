#!/usr/bin/env bash
# Installs the extension with the syntax highlighting of the ARM assembly of the course in VS Code, for the current
# user. Needs VS Code (install_vscode.sh of vscode-arm-syntax-docker). Installs the latest release, downloaded into
# assets/ by scripts/download_assets.sh, or the .vsix file given in VSIX. Can be run in an Ubuntu / Debian host from a
# checkout of the repository, and is also used by the BMDE Docker images.
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
vsix="${VSIX:-${SCRIPT_DIR}/../assets/arm-syntax-vscode-extension.vsix}"
if [ ! -f "${vsix}" ]; then
  echo "${vsix} not found: download it with scripts/download_assets.sh" >&2
  exit 1
fi

code --install-extension "${vsix}" --force
