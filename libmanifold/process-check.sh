#!/usr/bin/env bash

# cd to the root of the repo
cd "$(git rev-parse --show-toplevel)"

if [[ ! -v PROCESS_RUNNING ]]; then
  exit 127
fi
