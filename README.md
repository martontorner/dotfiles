# .dotfiles

My [dotfiles] repository.

## Install

### git

```shell
git clone https://github.com/martontorner/.dotfiles.git ~/.dotfiles && ~/.dotfiles/bootstrap.sh
```

### curl

```shell
rm -rf ~/.dotfiles && mkdir -p ~/.dotfiles
curl -#L https://github.com/martontorner/dotfiles/tarball/main | tar -xzv -C ~/.dotfiles --strip-components 1 && ~/.dotfiles/bootstrap.sh
```

## Extra

The ~/.extra to be sourced along with other tools. You can use this file to override some settings or add additional functionalities.

### Git Credentials (example)

The .gitconfig file includes the `~/.gitconfig.user` file (created by the
bootstrap script since git cannot handle optional includes), you can use this
file to add some user specific configs that are not part of this repository.

<!-- prettier-ignore -->
>[!IMPORTANT]
>**Use your own credentials to prevent impersonating someone.**

```shell
### GIT ###
GIT_USER_CONFIG_FILE="${HOME}/.gitconfig.user"
GIT_USER_NAME="Márton Torner"
GIT_USER_EMAIL="29036669+martontorner@users.noreply.github.com"
GIT_USER_SIGNINGKEY="<GPG_KEY_ID>"

GITHUB_USERNAME="martontorner"

GIT_AUTHOR_NAME="${GIT_USER_NAME}"
GIT_COMMITTER_NAME="${GIT_AUTHOR_NAME}"
GIT_AUTHOR_EMAIL="${GIT_USER_EMAIL}"
GIT_COMMITTER_EMAIL="${GIT_AUTHOR_EMAIL}"
git config --file "${GIT_USER_CONFIG_FILE}" user.name "${GIT_USER_NAME}"
git config --file "${GIT_USER_CONFIG_FILE}" user.email "${GIT_USER_EMAIL}"
git config --file "${GIT_USER_CONFIG_FILE}" user.signingkey "${GIT_USER_SIGNINGKEY}"
git config --global include.path "${GIT_USER_CONFIG_FILE}"
### GIT ###
```

## Development

### Prepare

Prepare local development environment:
```shell
make prepare
```

[dotfiles]: https://dotfiles.github.io
