#!/bin/bash
( while true; do npm start & echo $! >log/server.pid; wait; rm log/server.pid; sleep 10; done ) 2>&1 | tee log/server.log

