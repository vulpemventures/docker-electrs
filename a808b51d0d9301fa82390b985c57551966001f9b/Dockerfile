# Electrs build stage
FROM rust:latest AS builder

ARG COMMIT=253040e346664976c12e6c214ee2858a4dad2e06

RUN apt-get update
RUN apt-get install -y clang cmake 

RUN git clone https://github.com/blockstream/electrs && cd electrs && git checkout ${COMMIT}

WORKDIR /electrs

RUN cargo build --release --bin electrs

FROM debian:stable-slim AS websocat-installer

RUN apt-get update
RUN apt-get install -y wget

RUN wget https://github.com/vi/websocat/releases/download/v1.11.0/websocat.x86_64-unknown-linux-musl \
    && chmod +x websocat.x86_64-unknown-linux-musl \
    && mv websocat.x86_64-unknown-linux-musl /usr/local/bin/websocat

# Final stage
FROM debian:stable-slim

COPY --from=builder /electrs/target/release/electrs /usr/local/bin
COPY --from=websocat-installer /usr/local/bin/websocat /usr/local/bin

COPY entrypoint.sh /entrypoint.sh

STOPSIGNAL SIGINT

ENTRYPOINT ["bash", "/entrypoint.sh"]
