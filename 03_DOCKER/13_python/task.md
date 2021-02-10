# Build new image

- Use base image krajewskim/python-api:base
- Set working dir to /usr/src/app
- execute command in image `pip install --no-cache-dir -r requirements.txt`
- allow port access on `5002`
- add env variable called `LOG_LEVEL` with value `INFO`
- run command `python` and `main.py`

# Run container form builded image
Verify with curl endpoints (don't forget about port!)

`/healthz`
`/api/v1/info`

# Update LOG LEVEL to DEBUG in run command

`docker container logs -f <container_name|docker id>`