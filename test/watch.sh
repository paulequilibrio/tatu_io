#!/usr/bin/env bash

inotifywait --quiet --recursive --monitor --excludei '(build|data|driver.bin)' \
            --event close_write . ../source | while read -r line; do
  clear
  make
done
