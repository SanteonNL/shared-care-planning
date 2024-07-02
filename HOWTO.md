# Docker

## Create the docker image

```shell
docker build . -t scp
```

## Run the docker image
```shell
docker run --name=scp --rm -v "$(pwd)/input":/app/input -v "$(pwd)/output":/app/output scp
```

## Run Go-FSH on zib2020 examples
```
@> npm install -g gofsh
@> mkdir _local
@> cd _local
@> cp -r zib2020/examples .
@> gofsh examples -t xml-only
```
