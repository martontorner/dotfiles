if command -v jless > /dev/null 2>&1; then
  alias -s json=jless
else
  alias -s json=cat
fi
if command -v bat > /dev/null 2>&1; then
  alias -s md=bat
  alias -s txt=bat
  alias -s log=bat
else
  alias -s md=cat
  alias -s txt=cat
  alias -s log=cat
fi
alias -s js='$EDITOR'
alias -s ts='$EDITOR'
alias -s py='$EDITOR'
alias -s go='$EDITOR'
alias -s yaml='$EDITOR'
if command -v open > /dev/null 2>&1; then
  # macOS: open in default browser
  alias -s html=open
  alias -s pdf=open
fi

# Redirect stdout to /dev/null
alias -g NO='> /dev/null'
# Redirect stderr to /dev/null
alias -g NE='2> /dev/null'
# Redirect both stdout and stderr to /dev/null
alias -g N='> /dev/null 2>&1'

alias -g J='| jq'

if command -v pbcopy > /dev/null 2>&1; then
  # Copy output to clipboard (macOS)
  alias -g C='| pbcopy'
elif command -v xclip > /dev/null 2>&1; then
  # Copy output to clipboard (Linux with xclip)
  alias -g C='| xclip -selection clipboard'
fi
