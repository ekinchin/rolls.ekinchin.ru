#!/usr/bin/env sh
set -eu

ROOT=$(cd "$(dirname "$0")/.." && pwd)

grep -q 'data-gallery-link' "$ROOT/src/layouts/contacts.njk"
grep -q 'class="lightbox"' "$ROOT/src/layouts/contacts.njk"
grep -q 'data-lightbox-prev' "$ROOT/src/layouts/contacts.njk"
grep -q 'data-lightbox-next' "$ROOT/src/layouts/contacts.njk"
grep -q '/scripts/lightbox.js' "$ROOT/src/layouts/base.njk"
grep -q 'src/scripts' "$ROOT/.eleventy.js"
grep -q 'neutral' "$ROOT/src/styles/film.css"
grep -q 'ArrowLeft' "$ROOT/src/scripts/lightbox.js"
grep -q 'ArrowRight' "$ROOT/src/scripts/lightbox.js"
