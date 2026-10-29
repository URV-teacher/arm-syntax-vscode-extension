#!/usr/bin/env bash
# Tests that the extension with the syntax highlighting of the ARM assembly of the course is installed in VS Code.
set -Eeuo pipefail

code --list-extensions | tee /dev/stderr | grep -qi "aleixmt.nds-arm-assembly-syntax-highlight"
echo "ARM syntax extension OK"
