#!/usr/bin/env sh

# TODO: correctly handle font installation, currently this is broken

# Restart processes and clear caches
atsutil databases -remove
killall fontd
