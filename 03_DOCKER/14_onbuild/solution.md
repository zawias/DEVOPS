# Build on-build image in Base folder

`docker image build -t base-python:on-build Base`

# Build image based on previous

`docker build -t python-api:redis .`

# Connect python with redis

```
docker run -d redis:alpine
docker run -d -p 5002:5002: -e REDIS_HOST=<?> -e REDIS_PORT=<?> -e LOG_LEVEL=DEBUG python-api:redis
```


```
curl 127.0.0.1:5002/api/v1/info
curl -XPOST 127.0.0.1:5002/api/v1/info
curl 127.0.0.1:5002/api/v1/info
```


- see `logs -f` in second window
docker logs -f <?>
