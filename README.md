# minio-image-to-webp
change images to webp by minio notification

# support image types
*image/jpeg* *image/png*
# quick start
*set up minio*
```
mc alias set minio http://localhost:9000 minio minio123
mc admin config set minio notify_redis:1 address="localhost:6379" format="access" key="MINIO_BUCKET_NOTIFY:IMAGE" password="" queue_dir="" queue_limit="0"
mc mb minio/image
mc event add minio/image arn:minio:sqs::1:redis --suffix .jpg --event put
mc event add minio/image arn:minio:sqs::1:redis --suffix .jpeg --event put
mc event add minio/image arn:minio:sqs::1:redis --suffix .jfif --event put
mc event add minio/image arn:minio:sqs::1:redis --suffix .png --event put
mc event list minio/image
arn:minio:sqs::1:redis   s3:ObjectCreated:*   Filter: suffix=".jpg"
arn:minio:sqs::1:redis   s3:ObjectCreated:*   Filter: suffix=".jpeg"
arn:minio:sqs::1:redis   s3:ObjectCreated:*   Filter: suffix=".png"
arn:minio:sqs::1:redis   s3:ObjectCreated:*   Filter: suffix=".jfif"
```
*docker-compose.yml*
```
  minio-image-to-webp:
    image: 9d77v/minio-image-to-webp:2021-06-14_10beeef
    restart: always
    container_name: minio-image-to-webp
    environment:
      - TZ=Asia/Shanghai
      - REDIS_ADDRESS=redis:6379
      - REDIS_PASSWORD=
      - REDIS_LIST=MINIO_BUCKET_NOTIFY:IMAGE
      - MINIO_BUCKET=image
      - MINIO_ADDRESS=minio:9000
      - MINIO_ACCESS_KEY_ID=minio
      - MINIO_SECRET_ACCESS_KEY=minio123
      - MINIO_USE_SSL=false
      - WEBP_QUALITY=75 #75%
      - MODE=0 #0:upload xxx.webp to minio,1:replace origin image with webp content,2:upload xxx.webp to minio and delete origin image
```
