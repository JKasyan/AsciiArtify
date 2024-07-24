#!/bin/bash
set -e

VERSION=$(git describe --tags --abbrev=0)
if [ -z $VERSION ];then
  echo "version is empty"
fi
TAG=ekasyan/AsciiArtify:$VERSION
echo $TAG - $VERSION

docker build -t . ekasyan/AsciiArtify:$VERSION
docker push $TAG