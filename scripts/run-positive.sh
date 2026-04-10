#!/usr/bin/env bash
# Positive: root package builds and tests pass.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
echo "== RTKSwift (positive): swift build =="
swift build
echo "== RTKSwift (positive): swift test =="
swift test
