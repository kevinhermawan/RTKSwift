#!/usr/bin/env bash
# Negative build: expect non-zero exit from swift build.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/Fixtures/NegativeBuild"
echo "== NegativeBuild (expect failure): swift build =="
if swift build; then
  echo "error: expected swift build to fail" >&2
  exit 1
fi
echo "OK: build failed as expected."
exit 0
