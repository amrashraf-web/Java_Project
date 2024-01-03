#!/bin/bash
set -euo pipefail
COMMIT_HASH=$(git rev-parse HEAD)
echo $COMMIT_HASH
