#!/bin/bash
# Got Tags
set -euo pipefail
COMMIT_HASH=$(git rev-parse HEAD)
echo $COMMIT_HASH
