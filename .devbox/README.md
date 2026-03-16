# Devbox Image

Custom base image for [Namespace Devboxes](https://namespace.so/docs/solutions/devboxes/images).

## Build

```sh
devbox image build . --name=rcrowe-$(date +%d%b | tr A-Z a-z) -f .devbox/Dockerfile
```

The build runs on Namespace's remote builders — no local Docker required. The
image is published to your workspace and available immediately for creating
devboxes.

## Create a devbox

Use the image name from your build:

```sh
devbox create --image=rcrowe-14mar
```
