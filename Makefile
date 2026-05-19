.DEFAULT_GOAL := help
.PHONY : help prepare bootstrap vscode-export-extensions vscode-import-extensions

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

prepare:  ## Prepare the development environment.
	@git config --local include.path ../.gitconfig

bootstrap:  ## Install/upgrade dotfiles.
	@./bootstrap.sh

brew: ## Install/upgrade Homebrew packages.
	@brew bundle --file brew/Brewfile
	@brew bundle --file fonts/Brewfile
	@brew bundle --file vscode/Brewfile

vscode-export-extensions:  ## Export VS Code extensions.
# 	@code --list-extensions | sort > vscode/extensions.txt
	@brew bundle dump --vscode --file vscode/Brewfile --force

vscode-import-extensions:  ## Import VS Code extensions.
# 	@xargs -n 1 code --install-extension < vscode/extensions.txt
	@brew bundle --vscode --file vscode/Brewfile
	@code --install-extension vscode/angular-cli-schematics-0.0.1.vsix
