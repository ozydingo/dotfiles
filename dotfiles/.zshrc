# Set up homebrew
eval $(/opt/homebrew/bin/brew shellenv)
# Add site-functions to fpath; recommended by pure
fpath+=("$(brew --prefix)/share/zsh/site-functions")

# Activate asdf tool manager if it exists and not already in PATH
asdf_dir=${ASDF_DATA_DIR:-$HOME/.asdf}
if [[ -d "$asdf_dir" && "$PATH" != *"$asdf_dir/shims"* ]]; then
  export PATH="$asdf_dir/shims:$PATH"
fi

# Add Google Cloud SDK to PATH.
if [ -f '$HOME/.local/google-cloud-sdk/path.zsh.inc' ]; then
    . '$HOME/.local/google-cloud-sdk/path.zsh.inc'
fi

# Add shell command completion for Google Cloud SDK.
# if [ -f '$HOME/.local/google-cloud-sdk/completion.zsh.inc' ]; then
#     . '$HOME/.local/google-cloud-sdk/completion.zsh.inc'
# fi

[[ "$PATH" == *"$HOME/bin:"* ]] || export PATH="$HOME/bin:$PATH"

! { which werf | grep -qsE "^$HOME/.trdl/"; } && [[ -x "$HOME/bin/trdl" ]] && source $("$HOME/bin/trdl" use werf "1.2" "stable")
