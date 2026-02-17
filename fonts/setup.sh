#!/usr/bin/env sh

cp "${DOTFILES}/fonts/"*.ttf "${HOME}/Library/Fonts/"

# Restart processes and clear caches
atsutil databases -remove
killall fontd
