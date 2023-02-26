#!/bin/sh
set -ex

if [ -n "$(git status --porcelain)" ]; then
    echo "Working directory is not clean" >&2
    exit 1
fi

VCS_REF="$(git rev-parse HEAD)"
BUILD_DATE="$(date --iso-8601=seconds)"

rm -rf out
mkdir out
echo "Document version: ${VCS_REF} ${BUILD_DATE}" > docs/version.mdpp
./build

rsync -v html brian@master.linuxpenguins.xyz:/var/www/html/brian/resume
git checkout html/index.html
