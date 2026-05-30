# UVtools Linux ARM64 Docker Image

This project packages a prebuilt UVtools `v6.0.3` `linux-arm64` release into a reusable Docker image.

It is intended for Apple Silicon Macs, ARM64 Linux hosts, CI runners, and ARM64 servers that need the UVtools command-line tools inside a container.

## Contents

- `Dockerfile` builds an Ubuntu-based image with UVtools installed under `/opt/uvtools`.
- `dist/uvtools-linux-arm64-v6.0.3.zip` is the prebuilt UVtools `linux-arm64` package.
- `scripts/build.sh` builds the Docker image reproducibly.
- `scripts/verify.sh` verifies that `UVtoolsCmd` starts and reports the expected core version.

## Requirements

- Docker Desktop or Docker Engine with ARM64 support
- The checked-in `dist/uvtools-linux-arm64-v6.0.3.zip` artifact

## Build

```bash
./scripts/build.sh
```

By default this builds:

```text
uvtools-linux-arm64:6.0.3
```

You can override the image name:

```bash
IMAGE_NAME=ghcr.io/YOUR_GITHUB_USERNAME/uvtools-linux-arm64:6.0.3 ./scripts/build.sh
```

## Verify

```bash
./scripts/verify.sh
```

Expected output includes:

```text
6.0.3
```

## Run

Show CLI help:

```bash
docker run --rm --platform linux/arm64 uvtools-linux-arm64:6.0.3
```

Check UVtools core version:

```bash
docker run --rm --platform linux/arm64 uvtools-linux-arm64:6.0.3 uvtoolscmd --core-version
```

Mount a local folder and process files:

```bash
docker run --rm --platform linux/arm64 \
  -v "$PWD:/workspace" \
  uvtools-linux-arm64:6.0.3 \
  uvtoolscmd print-properties /workspace/example.ctb
```

## Publish To GitHub Container Registry

Create a GitHub repository, push this project, then build and push the image locally:

```bash
export IMAGE_NAME=ghcr.io/YOUR_GITHUB_USERNAME/uvtools-linux-arm64:6.0.3

./scripts/build.sh
docker push "$IMAGE_NAME"
```

You need to be logged in first:

```bash
echo "$GITHUB_TOKEN" | docker login ghcr.io -u YOUR_GITHUB_USERNAME --password-stdin
```

This repository also includes a GitHub Actions workflow at `.github/workflows/publish-ghcr.yml`.

After pushing the repository to GitHub, create and push a tag to publish automatically:

```bash
git tag v6.0.3
git push origin v6.0.3
```

The workflow publishes:

```text
ghcr.io/YOUR_GITHUB_USERNAME/uvtools-linux-arm64:6.0.3
ghcr.io/YOUR_GITHUB_USERNAME/uvtools-linux-arm64:latest
```

## Artifact Information

Bundled artifact:

```text
dist/uvtools-linux-arm64-v6.0.3.zip
```

SHA256:

```text
0df3b139c5239ac76cccb0706a9557b5c22786e68e9bf74c801aebb6528d99a2
```

The bundled binaries were built from UVtools `v6.0.3`:

```text
https://github.com/sn4k3/UVtools/releases/tag/v6.0.3
```

## License

UVtools is licensed under `AGPL-3.0-or-later`. See `NOTICE.md` for upstream source and license information.
