#-------------------------------------------------------------------------------
# Running `make` will show the list of subcommands that will run.

all: help

.PHONY: help
## help: prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

#-------------------------------------------------------------------------------
# Base Docker images so that we have some repeatability

.PHONY: build
## build: [build] Builds a Docker image for the current CPU architecture.
build: clean
	DOCKER_BUILDKIT=1 docker buildx build \
		--output=type=docker \
		--load \
		--tag skyzyx/nginx-hello-world:latest \
		--compress \
		--force-rm \
		--file Dockerfile \
		.

.PHONY: buildx
## buildx: [build] Builds a Docker image for Intel and ARM CPU architectures, and then push them.
buildx: clean
	DOCKER_BUILDKIT=1 docker buildx build \
		--platform linux/amd64,linux/arm64 \
		--output=type=image,push=true \
		--tag skyzyx/nginx-hello-world:latest \
		--compress \
		--force-rm \
		--file Dockerfile \
		.

.PHONY: run
## run: [build] Run the Docker image locally.
run:
	- open http://localhost:8080
	docker run -p 8080:80 skyzyx/nginx-hello-world:latest

#-------------------------------------------------------------------------------
# Clean Docker containers

.PHONY: clean
## clean: [clean] Deletes the Docker image that this Makefile builds.
clean:
	docker image rm --force skyzyx/nginx-hello-world:latest

#-------------------------------------------------------------------------------
# Linting

.PHONY: hadolint
## hadolint: [lint] Runs `hadolint` (static analysis) against the Dockerfile.
hadolint:
	@ echo " "
	@ echo "=====> Running Hadolint..."
	- hadolint Dockerfile
