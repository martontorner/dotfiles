#!/usr/bin/env sh

curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

# Correct permissions
chmod go-w /opt/homebrew/share
