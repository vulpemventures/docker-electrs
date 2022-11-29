# Electrs build stage
FROM rust:latest AS electrs-builder

ARG COMMIT=253040e346664976c12e6c214ee2858a4dad2e06

RUN apt-get update
RUN apt-get install -y clang cmake

RUN git clone https://github.com/blockstream/electrs && cd electrs && git checkout ${COMMIT}

WORKDIR /electrs

RUN cargo build --release --bin electrs

# websocat build stage
FROM rust:1.60-alpine3.15 as cargo-build

RUN apk add --no-cache musl-dev pkgconfig openssl-dev git

RUN git clone https://github.com/vi/websocat.git && cd websocat && git checkout v1.11.0

WORKDIR /websocat

ARG CARGO_OPTS="--features=workaround1,seqpacket,prometheus_peer,prometheus/process,crypto_peer"

RUN cargo build --release --target=x86_64-unknown-linux-musl $CARGO_OPTS && \
    rm -f target/x86_64-unknown-linux-musl/release/deps/websocat*

RUN cargo build --release --target=x86_64-unknown-linux-musl $CARGO_OPTS && \
    strip target/x86_64-unknown-linux-musl/release/websocat

# Final stage
FROM debian:stable-slim

COPY --from=electrs-builder /electrs/target/release/electrs /usr/local/bin
COPY --from=cargo-build /websocat/target/x86_64-unknown-linux-musl/release/websocat /usr/local/bin

COPY entrypoint.sh /entrypoint.sh

STOPSIGNAL SIGINT

ENTRYPOINT ["bash", "/entrypoint.sh"]
