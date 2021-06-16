## Run nginx in normal mode

```
docker run --name mynginx nginx
```
## Run nginx in detached mode

```
docker run -d --name mynginx nginx
```

## stop & remove container

```
docker stop mynginx
docker rm mynginx
```

## start container with multiple env variables

```
docker run -d --name mynginx -e user=maciej topic=workshops nginx
```

## display env variables

```
docker exec -ti mynginx /bin/bash
```

## Force remove container

```
docker rm -f mynginx
```

