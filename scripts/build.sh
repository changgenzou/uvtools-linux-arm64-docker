#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE_NAME="${IMAGE_NAME:-uvtools-linux-arm64:6.0.3}"
PLATFORM="${PLATFORM:-linux/arm64}"
UVTOOLS_ZIP="${UVTOOLS_ZIP:-dist/uvtools-linux-arm64-v6.0.3.zip}"

if [[ ! -f "$ROOT_DIR/$UVTOOLS_ZIP" ]]; then
  echo "Missing artifact: $ROOT_DIR/$UVTOOLS_ZIP" >&2
  exit 1
fi

docker build \
  --platform "$PLATFORM" \
  --build-arg "UVTOOLS_ZIP=$UVTOOLS_ZIP" \
  -t "$IMAGE_NAME" \
  "$ROOT_DIR"

echo "Built image: $IMAGE_NAME"
