#!/usr/bin/env sh

read -r -p "Name: " GIT_USER_NAME
read -r -p "Email: " GIT_USER_EMAIL
read -r -s -p "Passphrase (GPG): " GPG_PASSPHRASE
echo


GPG_HOME="${HOME}/.gnupg"
mkdir -p "$GPG_HOME"
chmod 700 "$GPG_HOME"

gpg --batch --generate-key <<EOF
Key-Type: ed25519
Key-Usage: sign
Subkey-Type: cv25519
Subkey-Usage: encrypt
Name-Real: ${GIT_USER_NAME}
Name-Email: ${GIT_USER_EMAIL}
Passphrase: ${GPG_PASSPHRASE}
%commit
EOF

GIT_USER_SIGNINGKEY=$(gpg --list-secret-keys --keyid-format=long "${GIT_USER_EMAIL}" \
  | awk '/^sec/ { sub(".*/","",$2); print $2; exit }')

GIT_USER_CONFIG_FILE="${HOME}/.gitconfig.user"
git config --file "${GIT_USER_CONFIG_FILE}" user.name "${GIT_USER_NAME}"
git config --file "${GIT_USER_CONFIG_FILE}" user.email "${GIT_USER_EMAIL}"
git config --file "${GIT_USER_CONFIG_FILE}" user.signingkey "${GIT_USER_SIGNINGKEY}"
