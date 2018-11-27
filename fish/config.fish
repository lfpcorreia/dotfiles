# GOLANG
set -xU GOPATH $HOME/Code/golang
set -xU GOROOT /usr/local/opt/go/libexec
set -xU PATH $PATH $GOPATH/bin $GOROOT/bin

# *nix utils
set -xU PATH /usr/local/opt/findutils/libexec/gnubin $PATH
set -xU PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set -xU MANPATH $MANPATH /usr/local/opt/findutils/libexec/gnuman
set -xU MANPATH $MANPATH /usr/local/opt/coreutils/libexec/gnuman

# GitHub
# ADD TOKEN HERE set -xU HOMEBREW_GITHUB_API_TOKEN c45f8c6c85c26694738fd4405dd91570ab8fa917
set -xU NVM_DIR $HOME/.nvm

# Rust
set -xU PATH $PATH $HOME/.cargo/bin

# NVM
function nvm
    bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end

set -xU NVM_DIR ~/.nvm
nvm use default --silent
