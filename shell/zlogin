# enable colorized terminal output
export CLICOLOR=1
# Parse display and control chars in the less pager
export LESS=-R
# Set default editor for terminal tasks to emacs
export EDITOR=emacs

### Common dev tool aliases
alias b="bundle"
alias d="docker"
alias dc="docker compose"
alias k="kubectl"
# alias m="minikube"
# alias mk="minikube kubectl --"
alias n="node"
alias y="yarn"

# ssh to ephemeral servers without adding clutter to known_hosts
alias ssh0="ssh -o 'UserKnownHostsFile=/dev/null'"

source $HOME/script/gitprompt
zsh_colors

### PROMPT setup: timestamp, working dir, git branch; input on new line
setopt PROMPT_SUBST
git_prompt() {
  echo "[%F{$(git_branch_color)}$(parse_git_branch)%f]"
}
prompt_status_badge() {
  if [ $? -eq 0 ]; then
    echo "%F{green}✔%f"
  else
    echo "%F{red}✘%f"
  fi
}

export PROMPT='[%D{%Y-%m-%d %H:%M:%S}] $(prompt_status_badge) %F{blue}%~%f $(git_prompt)'$'\n''%F{green}$%f '


# Activate pure prompt
# autoload -U promptinit; promptinit
# prompt pure

# export PROMPT="%F{${prompt_pure_colors[path]}}%~%f
# %}%(12V.%F{$prompt_pure_colors[virtualenv]}%12v%f .)%(?.%F{$prompt_pure_colors[prompt:success]}.%F{$prompt_pure_colors[prompt:error]})${prompt_pure_state[prompt]}%f"

if [ -d "/Users/andrew/.local/bin" ]; then
  if ! echo "$PATH" | grep -q "/Users/andrew/.local/bin"; then
    export PATH="/Users/andrew/.local/bin:$PATH"
  fi
fi

# Add custom functions to shell
for file in $HOME/script/functions/*; do
    source "$file"
done

# $PROMPT references the last exit code; make this true on a new terminal
true
