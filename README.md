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

<!-- prettier-ignore -->
>[!IMPORTANT]
>**Use your own credentials to prevent impersonating someone.**

```shell
### GIT ###
GIT_USER_NAME="Márton Torner"
GIT_USER_EMAIL="29036669+martontorner@users.noreply.github.com"
GIT_USER_SIGNINGKEY="<GPG_KEY_ID>"

GIT_AUTHOR_NAME="$GIT_USER_NAME"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="$GIT_USER_EMAIL"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"
git config --global user.signingkey "$GIT_USER_SIGNINGKEY"
### GIT ###
```

## Development

### Prepare

Prepare local development environment:
```shell
make prepare
```

[dotfiles]: https://dotfiles.github.io
