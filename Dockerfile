# Base GCC image for compiling (CMAKE) i2c example code
FROM gcc:9.3.0

ADD https://github.com/Kitware/CMake/releases/download/v3.16.6/cmake-3.16.6-Linux-x86_64.sh /tmp/cmake-install.sh
RUN chmod u+x /tmp/cmake-install.sh \
    && mkdir /usr/bin/cmake \
    && /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
    && rm /tmp/cmake-install.sh
ENV PATH="/usr/bin/cmake/bin:${PATH}"

ADD https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2019q4/gcc-arm-none-eabi-9-2019-q4-major-x86_64-linux.tar.bz2 /usr/bin/gcc-arm-none-eabi-9-2019-q4-major.tar.bz
RUN tar -xjf /usr/bin/gcc-arm-none-eabi-9-2019-q4-major.tar.bz -C /usr/bin \
    && rm /usr/bin/gcc-arm-none-eabi-9-2019-q4-major.tar.bz
ENV PATH "/usr/bin/gcc-arm-none-eabi-9-2019-q4-major/bin:$PATH"

ENV OUTDIR=/out/builds

COPY ./source /usr/src/i2c
COPY ./include /usr/src/i2c
copy ./balena-fin-coprocessor-base /usr/src/i2c

# Defining working directory
WORKDIR /usr/src/i2c

CMD ["make","all"]