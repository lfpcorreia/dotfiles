# GOLANG
set -x -g GOPATH $HOME/Code/golang
set -x -g GOROOT /usr/local/opt/go/libexec
set -x -g PATH $PATH $GOPATH/bin $GOROOT/bin

# *nix utils
set -x -g PATH /usr/local/opt/findutils/libexec/gnubin $PATH
set -x -g PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set -x -g MANPATH $MANPATH /usr/local/opt/findutils/libexec/gnuman
set -x -g MANPATH $MANPATH /usr/local/opt/coreutils/libexec/gnuman

# GitHub
# ADD TOKEN HERE set -x -g HOMEBREW_GITHUB_API_TOKEN c45f8c ... b8fa917
set -x -g NVM_DIR $HOME/.nvm

# Rust
set -x -g PATH $PATH $HOME/.cargo/bin

# NVM
function nvm
    bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
end

set -x -g NVM_DIR ~/.nvm
nvm use default --silent
