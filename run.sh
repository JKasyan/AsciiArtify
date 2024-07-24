#!/bin/bash
set -e

VERSION=$(git describe --tags --abbrev=0)
if [ -z $VERSION ];then
  echo "version is empty"
fi
TAG=ekasyan/asciiartify:$VERSION
echo "tag -- $TAG"
echo "version -- $VERSION"

docker build -t $TAG .
#docker push $TAG