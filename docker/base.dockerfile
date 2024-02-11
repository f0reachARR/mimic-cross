# syntax=docker/dockerfile:1.4.2
ARG HOST_BASE_IMAGE
ARG HOST_BASE_IMAGE_TAG
ARG BASE_IMAGE
ARG BASE_IMAGE_TAG
ARG MIMIC_ARCH
# =======================================================================

FROM scratch as mimic-host-native

COPY docker/setup.sh /mimic-cross.deno/setup.sh

# =======================================================================

FROM ${HOST_BASE_IMAGE}:${HOST_BASE_IMAGE_TAG} as mimic-host-build

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        unzip \
        wget \
        xz-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists

# Download zig
RUN mkdir /zig
WORKDIR /zig
RUN wget -q https://ziglang.org/download/0.11.0/zig-linux-x86_64-0.11.0.tar.xz \
    && tar xf zig-linux-x86_64-0.11.0.tar.xz \
    && rm zig-linux-x86_64-0.11.0.tar.xz

COPY mimic-lib /mimic-lib
WORKDIR /mimic-lib
RUN /zig/zig-linux-x86_64-0.11.0/zig build

# Download deno
RUN mkdir -p /deno
WORKDIR /deno
RUN wget -q https://github.com/denoland/deno/releases/download/v1.39.1/deno-x86_64-unknown-linux-gnu.zip \
    && unzip ./deno-x86_64-unknown-linux-gnu.zip \
    && rm ./deno-x86_64-unknown-linux-gnu.zip

# =======================================================================

FROM tonistiigi/binfmt as binfmt
FROM ${HOST_BASE_IMAGE}:${HOST_BASE_IMAGE_TAG} as mimic-host

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        binutils \
        ca-certificates \
        patch \
        patchelf \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists
COPY --from=mimic-host-build /mimic-lib/zig-out/lib/libmimic-cross.so /usr/lib/x86_64-linux-gnu/
RUN mkdir -p /mimic-cross/bin/
COPY --from=mimic-host-build /deno/deno /mimic-cross/bin/mimic-deno
RUN arch > /mimic-cross/host_arch

COPY --from=binfmt /usr/bin/qemu-aarch64 /mimic-cross/internal/bin/qemu-aarch64
RUN ln -s ../../../usr/bin/bash /mimic-cross/internal/bin \
    && ln -s ../../../usr/bin/objdump /mimic-cross/internal/bin \
    && ln -s ../../../usr/bin/patch /mimic-cross/internal/bin \
    && ln -s ../../../usr/bin/patchelf /mimic-cross/internal/bin \
    && ln -s ../../../usr/bin/readelf /mimic-cross/internal/bin \
    && ln -s ../../../usr/sbin/chroot /mimic-cross/internal/bin

COPY mimic-cross.deno /mimic-cross.deno

# ======================================================================

FROM mimic-host as mimic-test-host

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        libc6-dev \
        sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists

COPY ./test/hello.c /test/hello.c
WORKDIR /test
RUN gcc -shared -o libhello.so hello.c \
    && gcc -shared -o libhello_runpath.so hello.c -Wl,-rpath,\$ORIGIN/foo:/path/to/lib \
    && gcc -shared -o libhello_runpath_origin.so hello.c -Wl,-rpath,\$ORIGIN/foo

ENV MIMIC_TEST_DATA_PATH=/test
RUN mkdir -p /test/deploy

# =======================================================================

FROM --platform=linux/${MIMIC_ARCH} ${BASE_IMAGE}:${BASE_IMAGE_TAG} as mimic-cross

COPY --from=mimic-host / /mimic-cross
RUN /mimic-cross/mimic-cross.deno/setup.sh