# esp32-micropython-image-builder
Build ESP32 Micropython images with your custom code included

## Example
- Create a `Dockerfile` alongside your code to copy your file(s) into the image:

```
FROM dcmorton/esp32-micropython-image-builder:latest

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
