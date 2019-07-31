# How to test local crave binary:
## Create docker image:
- `make crave-build CRAVE_BIN=~/Documents/work/crv/combined/buildmeup/src/crave/dist/crave CRAVE_LATEST_VERSION=test-tag`

## Push newly created tag
- Push Image: `docker push accupara/crave:test-tag-Linux-amd64`
- After successful push, you can use the image on other systems for testing.
- Please do not use latest tag for this. Latest tag is used for current stable crave binary

# How to release latest stable crave binary on github inside docker image:

## Create docker image:
- `make doitall DOCKER_EXTRA_FLAGS=--no-cache`
