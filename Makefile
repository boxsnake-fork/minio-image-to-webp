APP=minio-image-to-webp
IMAGE_TAG=$(shell git log --pretty=format:"%ad_%h" -1 --date=short)
dev:
	CGO_ENABLED=1 REDIS_ADDRESS=domain.local:6379 go run main.go

build:
	CGO_ENABLED=1 go build -ldflags "-s -w"
	upx -9 $(APP)
	docker build -t 9d77v/$(APP):$(IMAGE_TAG) .
	docker push 9d77v/$(APP):$(IMAGE_TAG)
	rm -r $(APP)
