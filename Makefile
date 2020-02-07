#-------------------------------------------------------------------------------
# Running `make` will show the list of subcommands that will run.

all:
	@cat Makefile | grep "^[a-z]" | sed 's/://' | awk '{print $$1}'

#-------------------------------------------------------------------------------

.PHONY: build
build:
	docker build --tag skyzyx/nginx-hello-world:latest .

.PHONY: run
run:
	- open http://localhost:8080
	docker run -p 8080:80 skyzyx/nginx-hello-world:latest

.PHONY: push
push:
	docker push skyzyx/nginx-hello-world:latest
