#!/bin/bash

PORT=$1

if [ -z "$PORT" ]; then
    echo "Usage: $0 <WS_PORT>"
    exit 1
fi

echo "Starting websocket server on port $PORT"

set -m
electrs&
websocat -b ws-l:127.0.0.1:$PORT tcp:127.0.0.1:50001&
fg %1