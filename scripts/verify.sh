#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="${IMAGE_NAME:-uvtools-linux-arm64:6.0.3}"
PLATFORM="${PLATFORM:-linux/arm64}"
EXPECTED_VERSION="${EXPECTED_VERSION:-6.0.3}"

actual_version="$(
  docker run --rm --platform "$PLATFORM" "$IMAGE_NAME" uvtoolscmd --core-version
)"

if [[ "$actual_version" != "$EXPECTED_VERSION" ]]; then
  echo "Version mismatch: expected $EXPECTED_VERSION, got $actual_version" >&2
  exit 1
fi

echo "Verified UVtools core version: $actual_version"
