#!/usr/bin/env bash
# Negative test: expect non-zero exit from swift test.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/Fixtures/NegativeTest"
echo "== NegativeTest (expect failure): swift test =="
if swift test; then
  echo "error: expected swift test to fail" >&2
  exit 1
fi
echo "OK: tests failed as expected."
exit 0
