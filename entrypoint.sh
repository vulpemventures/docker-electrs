#!/bin/bash

PORT=$1
ELECTRUM_RPC_PORT=$2

if [ -z "$PORT" ] || [ -z "$ELECTRUM_RPC_PORT" ]; then
    echo "Usage: $0 <WS_PORT> <ELECTRUM_RPC_PORT>"
    exit 1
fi

echo "Starting websocket server on port $PORT"

set -m
electrs&
websocat -b ws-l:127.0.0.1:$PORT tcp:127.0.0.1:$ELECTRUM_RPC_PORT&
fg %1