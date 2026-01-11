#!/usr/bin/env sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Correct permissions
chmod go-w /opt/homebrew/share
