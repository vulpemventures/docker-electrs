FROM rust:latest AS builder

ARG COMMIT=253040e346664976c12e6c214ee2858a4dad2e06

RUN apt-get update
RUN apt-get install -y clang cmake

RUN git clone https://github.com/blockstream/electrs && cd electrs && git checkout ${COMMIT}

WORKDIR /electrs

RUN cargo build --release --bin electrs

FROM debian:stable-slim

WORKDIR /build

COPY --from=builder /electrs/target/release/electrs /build

STOPSIGNAL SIGINT

ENTRYPOINT ["/build/electrs"]
