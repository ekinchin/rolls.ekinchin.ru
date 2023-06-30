#!/usr/bin/env sh

TARGET="src/rolls/$1"
SOURCE="new-roll"
ROOT=`pwd`
mkdir "${TARGET}"
mkdir "${TARGET}/photos"
cp ${SOURCE}/index.md "${TARGET}"

cd ${SOURCE}/photos/
for image in *.jpg; do
  convert $image -resize 480 $ROOT/$TARGET/photos/xs-$image
  convert $image -resize x1080 $ROOT/$TARGET/photos/$image
done
