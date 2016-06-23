#!/usr/bin/env bash

xprop -name __dropdown
rc=$?; if [[ $rc != 0 ]]; then # scratchpad doesn't exist
  termite --geometry 1000x200 --name __dropdown &
  sleep .2
fi
i3-msg '[instance="__dropdown"] scratchpad show'
