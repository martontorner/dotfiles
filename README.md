# dotfiles

My [dotfiles] repository.

## Install

```shell
curl -fsSL https://dotfiles.martontorner.com/install | sh ; exec $SHELL
```

## Update

```shell
${DOTFILES}/bootstrap.sh ; exec $SHELL
```

## Git Config (local)

The .gitconfig file includes the `~/.gitconfig.user` file (created by the
bootstrap script since git cannot handle optional includes), you can use this
file to add some user specific configs that are not part of this repository. The
git folder contains a setup script to generate user info.

## Extra

The ~/.extra to be sourced along with other tools. You can use this file to
override some settings or add additional functionalities.

Some shell functions use user-specific env variables, those should also be set
here, e.g.:

```shell
# ~/.extra

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
