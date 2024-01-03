#!/bin/bash
set -euo pipefail
VERSION=$(git describe --tags --match '0.*' | sed -e 's/^v//; s/-beta$//; s/^/0./; s/\.[0-9]*$/-beta/')
echo $VERSION
