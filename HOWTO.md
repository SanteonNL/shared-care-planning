# Docker

## Create and Setup Docker Image
```
> docker run --name=scp -it -v "$(pwd)":/app node:lts-buster /bin/bash
```

.. install GoFSH and sushi, see https://fshschool.org/docs/gofsh/installation/
.. install java, jekyll, graphviz (needed for plantuml) in Docker (required for IG tooling)

```
@> apt update
@> apt install jekyll graphviz
@> dpkg -i jdk-21_linux-x64_bin.deb
@> npm install -g fsh-sushi
```

## Run Go-FSH on zib2020 examples
```
@> npm install -g gofsh
@> mkdir _local
@> cd _local
@> cp -r zib2020/examples .
@> gofsh examples -t xml-only
```