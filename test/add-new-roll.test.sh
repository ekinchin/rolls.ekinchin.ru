#!/usr/bin/env sh
set -eu

ROOT=$(cd "$(dirname "$0")/.." && pwd)
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

cd "$TMP"
mkdir -p src/rolls/39 src/rolls/40 new-roll/photos
cp "$ROOT/add-new-roll.sh" .
cp "$ROOT/new-roll/index.md" new-roll/index.md
cp "$ROOT"/new-roll/photos/*.jpg new-roll/photos/

ROLL_DATE=2026-06-21 sh ./add-new-roll.sh

test -d src/rolls/41/photos
test -f src/rolls/41/index.md
grep -q '^number: 41$' src/rolls/41/index.md
grep -q '^date: 2026-06-21$' src/rolls/41/index.md

photo_count=$(find src/rolls/41/photos -maxdepth 1 -type f -name '*.jpg' | wc -l | tr -d ' ')
test "$photo_count" = 50

frontmatter_photo_count=$(grep -c '^  - number:' src/rolls/41/index.md)
test "$frontmatter_photo_count" = 25
grep -q '^  - number: 25$' src/rolls/41/index.md

if grep -q '^  - number: 26$' src/rolls/41/index.md; then
  echo "Generated too many photo entries" >&2
  exit 1
fi
