#!/bin/bash
set -m
electrs&
websocat -b ws-l:127.0.0.1:1234 tcp:127.0.0.1:50001&
fg %1