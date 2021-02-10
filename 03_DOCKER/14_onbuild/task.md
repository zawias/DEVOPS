# Build on-build image in Base folder

`docker image build -t base-python:on-build Base`

# Build image based on previous

`docker build -t python-api:redis .`

# Connect python with redis

- Run container from image `redis` on port `6379`
- run container from image `python-api:redis` on port `5002`

use REDIS_HOST, REDIS_PORT env to setup your IP


```
curl 127.0.0.1:5002/api/v1/info
curl -XPOST 127.0.0.1:5002/api/v1/info
curl 127.0.0.1:5002/api/v1/info
```

- set `LOG_LEVEL` to `DEBUG`
- see `logs -f` in second window

