FROM ubuntu:18.04
LABEL Name=esp32-micropython-image-builder Version=0.0.1
ENV ESPIDF /data/esp-idf
ENV MICROPYTHON /data/micropython

RUN apt update && apt -y install git build-essential python-virtualenv gcc git wget make libncurses-dev flex bison gperf python python-pip python-setuptools python-serial python-cryptography python-future python-pyparsing libffi-dev libssl-dev && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${ESPIDF} && mkdir -p ${MICROPYTHON}

RUN git clone -b v1.13 https://github.com/micropython/micropython.git ${MICROPYTHON} && wget --quiet -O ${MICROPYTHON}/ports/esp32/modules/urequests.py https://raw.githubusercontent.com/micropython/micropython-lib/master/urequests/urequests.py

RUN git clone https://github.com/espressif/esp-idf.git ${ESPIDF} && cd ${ESPIDF} && git checkout $(grep 'ESPIDF_SUPHASH_V3 :=' ${MICROPYTHON}/ports/esp32/Makefile | awk '{print $3}') && git submodule update --init --recursive

RUN wget --quiet -O /data/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz && tar xzf /data/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz -C /data

ENV PATH /data/xtensa-esp32-elf/bin:${PATH}

RUN cd ${MICROPYTHON}/mpy-cross && make mpy-cross

RUN cd ${MICROPYTHON}/ports/esp32 && make submodules

