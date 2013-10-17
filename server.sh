#!/bin/bash
( while true; do npm start & echo $! >server.pid; wait; rm server.pid; sleep 10; done ) 2>&1 | tee server.log

