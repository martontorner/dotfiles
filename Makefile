.DEFAULT_GOAL := help
.PHONY : prepare

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

prepare:  ## Prepare the development environment.
	@git config --local include.path ../.gitconfig

export-vscode-extensions:  ## Export VS Code extensions.
	@code --list-extensions | sort > vscode/extensions.txt

import-vscode-extensions:  ## Import VS Code extensions.
	@xargs -n 1 code --install-extension < vscode/extensions.txt
