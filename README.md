# esp32-micropython-image-builder
Build ESP32 Micropython images with your custom code included

This repository creates two separate images:
- `stable` - this image is built from the most recently tagged release of MicroPython
- `unstable` - this image is built from the tip of the master MicroPython repository

## Example Code
- Create a `Dockerfile` alongside your code to copy your file(s) into the image:

```
FROM dcmorton/esp32-micropython-image-builder:stable

COPY main.py ${MICROPYTHON}/ports/esp32/modules

WORKDIR ${MICROPYTHON}/ports/esp32

ENTRYPOINT ["make", "PYTHON=python"]
```

- Build the image from the `Dockerfile`
```
$ docker build -t esp32-image .
```

- Run docker container with above docker image
```
docker run -v $PWD/output:/data/micropython/ports/esp32/build-GENERIC/ esp32-image
```

- The firmware file will be in `$PWD/output/firmware.bin`.

## More Examples
The [esp32-dht22-upython](https://github.com/dcmorton/esp32-dht22-upython) project uses a similar [Dockerfile](https://github.com/dcmorton/esp32-dht22-upython/blob/master/Dockerfile) and [GitHub Action](https://github.com/dcmorton/esp32-dht22-upython/blob/master/.github/workflows/build.yml) to build a firmware image and upload the image to AWS S3.
