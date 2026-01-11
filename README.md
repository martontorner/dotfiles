# dotfiles

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
file to add some user specific configs that are not part of this repository. The
git folder contains a setup script to generate user info. Some shell functions
use user-specific env variables, those should also be set here. An example:

```shell
### GIT ###
GITHUB_USERNAME="martontorner"
### GIT ###
```

## Development

### Prepare

Prepare local development environment:
```shell
make prepare
```

[dotfiles]: https://dotfiles.github.io
