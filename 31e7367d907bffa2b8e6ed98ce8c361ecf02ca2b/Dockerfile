FROM rust:latest AS builder

ARG COMMIT=31e7367d907bffa2b8e6ed98ce8c361ecf02ca2b

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
