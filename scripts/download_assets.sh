#!/usr/bin/env bash
# Downloads the assets of arm-syntax-vscode-extension into assets/.
#
# The download logic is the one shared by every component of the BMDE (download_lib.sh, copied from bmde: see it for
# the details). The external resources are listed in the documentation of bmde (docs/development/external-resources.md).
#
#   scripts/download_assets.sh [ASSET...]    (every asset by default)
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
# shellcheck source=download_lib.sh
source "${SCRIPT_DIR}/download_lib.sh" "$@"

# Downloads the latest release of the extension into the file $1
# shellcheck disable=SC2329  # Called through a function: source of asset
download_extension() {
  local repo=URV-teacher/arm-syntax-vscode-extension version
  version="$(download "https://api.github.com/repos/${repo}/releases/latest" /dev/stdout | grep '"tag_name"' \
    | cut -d '"' -f 4)" || return 1
  download "https://github.com/${repo}/releases/download/${version}/arm-syntax-vscode-extension-${version#v}.vsix" "$1"
}

# The extension, installed by install_extension.sh unless VSIX gives another .vsix (latest version)
asset arm-syntax-vscode-extension.vsix "" function:download_extension

exit "${failed}"
