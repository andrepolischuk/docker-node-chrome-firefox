# node-chrome-firefox

> Docker image for browser tests

## Under the hood

Base image `andrepolischuk/node`

* Node
* npm
* yarn
* awscli

Image with browsers `andrepolischuk/node-chrome-firefox`

* ...Tools from base image
* Chrome
* Firefox

## Install

```sh
docker pull andrepolischuk/node
docker pull andrepolischuk/node-chrome-firefox
```

## Build the images

```sh
docker build -t andrepolischuk/node -f Dockerfile_base .
docker build -t andrepolischuk/node-chrome-firefox -f Dockerfile_browsers .
```

## License

MIT
