#!/usr/bin/env bash

UPDATES=$(checkupdates | wc -l)
[[ "${UPDATES}" -lt "20" ]] && exit 0

echo "   ${UPDATES} "
exit 0
