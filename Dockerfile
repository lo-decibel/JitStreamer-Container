FROM debian:stable-20230502-slim
RUN mkdir -p /JitStreamer /DMG \
    && apt-get update \
    && apt-get install -y \
        udev \
        libudev1 \
        libssl1.1 \
        libudev-dev \
        libssl-dev \
        python3-dev \
        build-essential \
        pkg-config \
        checkinstall \
        git autoconf \
        automake \
        libtool-bin \
        curl \
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && . "$HOME/.cargo/env" \
    && git clone https://github.com/libusb/libusb /build/libusb \
    && cd /build/libusb && git checkout cc498de \
    && ./autogen.sh && make install \
    && git clone https://github.com/libimobiledevice/libplist /build/libplist \
    && cd /build/libplist && git checkout bfc9778 \
    && ./autogen.sh && make install \
    && git clone https://github.com/libimobiledevice/libimobiledevice-glue /build/libimobiledevice-glue \
    && cd /build/libimobiledevice-glue && git checkout d2ff796 \
    && ./autogen.sh && make install \
    && git clone https://github.com/libimobiledevice/libusbmuxd /build/libusbmuxd \
    && cd /build/libusbmuxd && git checkout f47c36f \
    && ./autogen.sh && make install \
    && git clone https://github.com/libimobiledevice/libimobiledevice /build/libimobiledevice \
    && cd /build/libimobiledevice && git checkout 963083b \
    && ./autogen.sh && make install \
    && git clone https://github.com/libimobiledevice/usbmuxd /build/usbmuxd \
    && cd /build/usbmuxd && git checkout d0cda19 \ 
    && ./autogen.sh && make install \
    && git clone https://github.com/jkcoxson/JitStreamer/ /build/JitStreamer \
    && cd /build/JitStreamer && git checkout c2fda05 \
    && sed -i 's/,\?\s*"vendored"//g' Cargo.toml \
    && cargo build --release \
    && mv target/release/jit_streamer /JitStreamer \
    && mv /build/JitStreamer/target/release/pair /JitStreamer \
    && rm -r /build \
    && cd / && rustup self uninstall -y \
    && apt-get remove -y \
        libudev-dev \
        libssl-dev \
        python3-dev \
        build-essential \
        pkg-config \
        checkinstall \
        git \
        autoconf \
        automake \
        libtool-bin \
        curl \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

COPY ./scripts/pair-device.sh /usr/local/bin/pair-device
COPY ./scripts/entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/pair-device /usr/local/bin/entrypoint
WORKDIR /JitStreamer
ENTRYPOINT entrypoint
