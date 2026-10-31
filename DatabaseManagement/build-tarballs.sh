#!/usr/bin/env bash
# Rebuilds the dataset tarballs from the JSON files in this repository.
#
# The tarballs are what downstream packages read (e.g. the FusionRings Julia
# artifacts and the site's "Complete dataset" downloads), so they must always
# match the JSON. They are reproducible: the same files always give the same
# bytes, so an unchanged dataset never produces a new tarball.
#
# A tarball is only rewritten when its contents change, so a different gzip
# version on the runner does not cause spurious updates.
#
# Usage: DatabaseManagement/build-tarballs.sh [output root]   (default: repo root)

set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
out="${1:-$root}"

# tarball (relative to the root) => directory it packs
tarballs=(
  "AlgebraicStructures/FusionRings.tar.gz:AlgebraicStructures/FusionRings"
  "AlgebraicStructures/FusionCategories.tar.gz:AlgebraicStructures/FusionCategories"
  "SupportingData/AlgebraicNumbers.tar.gz:SupportingData/AlgebraicNumbers"
)

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

for entry in "${tarballs[@]}"; do
  tarball="${entry%%:*}"
  dir="${entry#*:}"
  tar="$tmp/$(basename "$tarball" .gz)"

  tar --create --file="$tar" --directory="$root/$(dirname "$dir")" \
    --sort=name --format=gnu --mtime="1970-01-01 00:00:00Z" \
    --owner=0 --group=0 --numeric-owner --mode="u+rwX,go+rX,go-w" \
    "$(basename "$dir")"

  dest="$out/$tarball"
  if [ -f "$dest" ] && gzip -dc "$dest" | cmp --silent - "$tar"; then
    echo "unchanged  $tarball"
    continue
  fi

  mkdir -p "$(dirname "$dest")"
  gzip -9 --no-name --stdout "$tar" >"$dest"
  echo "rebuilt    $tarball"
done
