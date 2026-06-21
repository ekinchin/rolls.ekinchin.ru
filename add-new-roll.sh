#!/usr/bin/env sh
set -eu

SOURCE="new-roll"
ROLLS_DIR="src/rolls"
ROOT=$(pwd)

if [ ! -d "$SOURCE/photos" ]; then
  echo "Missing source photos directory: $SOURCE/photos" >&2
  exit 1
fi

if [ ! -f "$SOURCE/index.md" ]; then
  echo "Missing source template: $SOURCE/index.md" >&2
  exit 1
fi

LAST_ROLL=$(find "$ROLLS_DIR" -maxdepth 1 -type d | awk -F/ '
  $NF ~ /^[0-9]+$/ && $NF > max { max = $NF }
  END { print max + 0 }
')
NEXT_ROLL=$((LAST_ROLL + 1))
PUBLISH_DATE=${ROLL_DATE:-$(date +%F)}
TARGET="$ROLLS_DIR/$NEXT_ROLL"
PHOTOS=$(find "$SOURCE/photos" -maxdepth 1 -type f -name '*.jpg' | sort -V)

if [ -z "$PHOTOS" ]; then
  echo "No JPG photos found in $SOURCE/photos" >&2
  exit 1
fi

if [ -e "$TARGET" ]; then
  echo "Target already exists: $TARGET" >&2
  exit 1
fi

mkdir "$TARGET"
mkdir "$TARGET/photos"

awk -v number="$NEXT_ROLL" -v publish_date="$PUBLISH_DATE" '
  $0 == "photos:" { print "photos:"; exit }
  /^number:/ { print "number: " number; next }
  /^date:/ { print "date: " publish_date; next }
  { print }
' "$SOURCE/index.md" > "$TARGET/index.md"

for photo in $PHOTOS; do
  image=$(basename "$photo")
  number=${image%.jpg}

  printf '  - number: %s\n    description:\n' "$number" >> "$TARGET/index.md"
  convert "$photo" -resize 480 "$ROOT/$TARGET/photos/xs-$image"
  convert "$photo" -resize x1080 "$ROOT/$TARGET/photos/$image"
done

printf '%s\n' '---' >> "$TARGET/index.md"
printf 'Created roll %s at %s\n' "$NEXT_ROLL" "$TARGET"
