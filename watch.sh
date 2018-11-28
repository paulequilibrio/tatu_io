#!/usr/bin/env bash

inotifywait --quiet --recursive --monitor --excludei '(build|data|test|example.bin)' \
            --event close_write . | while read -r line; do
  clear
  make
  ./example.bin -i data/input.json -o output/output.json
done
