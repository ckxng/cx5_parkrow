#!/bin/bash
( while true; do node docapp.js & echo $! >log/docserver.pid; wait; rm log/docserver.pid; sleep 10; done ) 2>&1 | tee log/docserver.log


