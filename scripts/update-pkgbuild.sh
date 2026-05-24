#!/usr/bin/env bash
set -euo pipefail

VERSION=$(grep '^version' Cargo.toml | sed 's/version = "\(.*\)"/\1/' | head -1)
TAG="v${VERSION}"

echo "Updating PKGBUILD to ${TAG}..."

curl -fsSL "https://github.com/yatoub/susshi/archive/refs/tags/${TAG}.tar.gz" \
    -o /tmp/susshi-archive.tar.gz
B2SUM=$(b2sum /tmp/susshi-archive.tar.gz | cut -d' ' -f1)

sed -i "s/^pkgver=.*/pkgver=${VERSION}/" PKGBUILD
sed -i "s/^pkgrel=.*/pkgrel=1/" PKGBUILD
sed -i "s/^b2sums=(.*/b2sums=(${B2SUM})/" PKGBUILD

echo "Done: pkgver=${VERSION}, b2sums=${B2SUM}"
