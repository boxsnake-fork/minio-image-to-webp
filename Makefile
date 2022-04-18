APP=minio-image-to-webp
IMAGE_TAG=$(TAROS)-$(ARCH)
DOCKER_FILE=Dockerfile.$(IMAGE_TAG)

dev:
	CGO_ENABLED=1 GOOS=$(TAROS) GOARCH=$(ARCH) REDIS_ADDRESS=domain.local:6379 go run main.go

build:
	CGO_ENABLED=1 GOOS=$(TAROS) GOARCH=$(ARCH) go build -ldflags "-s -w"
	upx -9 $(APP)
	docker build -f $(DOCKER_FILE) -t boxsnakefork/$(APP):$(IMAGE_TAG) .
	docker push boxsnakefork/$(APP):$(IMAGE_TAG)
	rm -r $(APP)
