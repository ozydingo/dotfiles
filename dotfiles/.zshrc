# Activate asdf tool manager
# Obsolete as of late 2025?
#. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Set up homebrew
eval $(/opt/homebrew/bin/brew shellenv)
# Add site-functions to fpath; recommended by pure
fpath+=("$(brew --prefix)/share/zsh/site-functions")

## WIP allow ruby build and gem build to work with openssl issues / M1 arm64

# # Unclear if these are necessary; they may have helped install ruby with correct configs/libs for m1
# export RUBY_CFLAGS="-Wno-error=implicit-function-declaration"
# # export RUBY_CFLAGS=-DUSE_FFI_CLOSURE_ALLOC
# export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
# export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"

# Save time by using already built openssl
# TODO: try just the openssl config. It wasn't working before perhaps because I didn't use export
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/homebrew/opt/openssl@1.1"
# PATH=/opt/homebrew/bin:$PATH
# export RUBY_CONFIGURE_OPTS="--with-zlib-dir=$(brew --prefix zlib) --with-openssl-dir=$(brew --prefix openssl@1.1) --with-readline-dir=$(brew --prefix readline) --with-libyaml-dir=$(brew --prefix libyaml)"

# https://riffraff.info/2022/10/ruby-rvm-macports-and-openssl-on-macos-monterey/
# export PKG_CONFIG_PATH=/opt/homebrew/opt/openssl@1.1/../1.1.1q/lib/pkgconfig
# export PKG_CONFIG_PATH=/opt/homebrew/opt/openssl@1.1/lib/pkgconfig
# export PGK_CONFIG_PATH=/opt/homebrew/Cellar/openssl@1.1/1.1.1q/lib/pkgconfig
# Used for rvm; what's the equiv asdf?
#rvm reinstall 2.7.6 --with-openssl-lib=/opt/local/lib/openssl-1.1 --with-openssl-include=/opt/local/include/openssl-1.1

### end ruby build workarounds

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/andrew/.local/google-cloud-sdk/path.zsh.inc' ]; then
    . '/Users/andrew/.local/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/andrew/.local/google-cloud-sdk/completion.zsh.inc' ]; then
#     . '/Users/andrew/.local/google-cloud-sdk/completion.zsh.inc'
# fi

[[ "$PATH" == *"$HOME/bin:"* ]] || export PATH="$HOME/bin:$PATH"
! { which werf | grep -qsE "^/Users/andrew/.trdl/"; } && [[ -x "$HOME/bin/trdl" ]] && source $("$HOME/bin/trdl" use werf "1.2" "stable")
