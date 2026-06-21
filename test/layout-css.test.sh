#!/usr/bin/env sh
set -eu

ROOT=$(cd "$(dirname "$0")/.." && pwd)
GALLERY_CSS="$ROOT/src/styles/gallery.css"

grep -q 'overflow-x: scroll;' "$GALLERY_CSS"
grep -q 'overflow-y: auto;' "$GALLERY_CSS"
grep -q 'scroll-snap-type: x mandatory;' "$GALLERY_CSS"
grep -q 'overscroll-behavior-y: contain;' "$GALLERY_CSS"
