# docker-html-pdf-chrome

[![github-actions](https://github.com/theohbrothers/docker-html-pdf-chrome/actions/workflows/ci-master-pr.yml/badge.svg?branch=master)](https://github.com/theohbrothers/docker-html-pdf-chrome/actions/workflows/ci-master-pr.yml)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/docker-html-pdf-chrome?style=flat-square)](https://github.com/theohbrothers/docker-html-pdf-chrome/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/docker-html-pdf-chrome/latest)](https://hub.docker.com/r/theohbrothers/docker-html-pdf-chrome)

Dockerized [html-pdf-chrome](https://github.com/westy92/html-pdf-chrome), with headless chromium running in the background.

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
| `:0.8.4`, `:latest` | [View](variants/0.8.4) |

- All images are based on `alpine`, and include `node` and `npm`

## Usage

To export a remote HTML page as .pdf:

```sh
docker run --rm -it -e URL=http://localhost -e PDF_FILE=export.pdf -v $(pwd):$(pwd) -w $(pwd) --network host theohbrothers/docker-html-pdf-chrome:0.8.4
docker run --rm -it -e URL=https://example.com -e PDF_FILE=export.pdf -v $(pwd):$(pwd) -w $(pwd) theohbrothers/docker-html-pdf-chrome:0.8.4
```

For export more complex cases, mount your custom script as `/export.js`:

```sh
docker run --rm -it -v $(pwd)/export.js:/export.js -v $(pwd):$(pwd) -w $(pwd) theohbrothers/docker-html-pdf-chrome:0.8.4 node /export.js
```

For a sleeping container (to reduce overhead of restarting chromium every run):

```sh
docker run --rm -it -e SLEEP=1 -v $(pwd):$(pwd) -w $(pwd) theohbrothers/docker-html-pdf-chrome:0.8.4
```

See [html-pdf-chrome](https://github.com/westy92/html-pdf-chrome#usage) usage.

## Development

Requires Windows `powershell` or [`pwsh`](https://github.com/PowerShell/PowerShell).

```powershell
# Install Generate-DockerImageVariants module: https://github.com/theohbrothers/Generate-DockerImageVariants
Install-Module -Name Generate-DockerImageVariants -Repository PSGallery -Scope CurrentUser -Force -Verbose

# Edit ./generate templates

# Generate the variants
Generate-DockerImageVariants .
```

### Variant versions

[versions.json](generate/definitions/versions.json) contains a list of [Semver](https://semver.org/) versions, one per line.

To update versions in `versions.json`:

```powershell
./Update-Versions.ps1
```

To update versions in `versions.json`, and open a PR for each changed version, and merge successful PRs one after another (to prevent merge conflicts), and finally create a tagged release and close milestone:

```powershell
$env:GITHUB_TOKEN = 'xxx'
./Update-Versions.ps1 -PR -AutoMergeQueue -AutoRelease
```

To perform a dry run, use `-WhatIf`.
