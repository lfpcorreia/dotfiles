# GitHub
set -x -g HOMEBREW_GITHUB_API_TOKEN 60f5fb8a9b4f3b36d1ba702f672b735846a5f871

# *nix utils
#set -x -g PATH /usr/local/opt/findutils/libexec/gnubin $PATH
#set -x -g PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set -x -g MANPATH $MANPATH /usr/local/opt/findutils/libexec/gnuman
set -x -g MANPATH $MANPATH /usr/local/opt/coreutils/libexec/gnuman

# GitHub
# ADD TOKEN HERE set -x -g HOMEBREW_GITHUB_API_TOKEN c45f8c ... b8fa917

# Rust
# set -x -g PATH $PATH $HOME/.cargo/bin

set -x -g DOCKER_ENV_DEV_LOG_PATH /Users/luiscorreia/Code/internations/app_data/logs
set -x -g DOCKER_ENV_DEV_MYSQL_DATA_PATH /Users/luiscorreia/Code/internations/app_data/mysql-data
set -x -g DOCKER_ENV_DEV_PROJECTS_PATH /Users/luiscorreia/Code/internations/
set -x -g DOCKER_ENV_DEV_SSH_PATH /Users/luiscorreia/.ssh
set -x -g DOCKER_ENV_DEV_GITCONFIG /Users/luiscorreia/.gitconfig
set -x -g DOCKER_ENV_DEV_USER_ID (id -u)
set -x -g DOCKER_ENV_DEV_GROUP_ID (id -g)

# PHP
set -g fish_user_paths "/usr/local/opt/php@7.2/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/php@7.2/sbin" $fish_user_paths
set -g fish_user_paths "$HOME/.composer/vendor/bin" $fish_user_paths

# PYTHON
set -g fish_user_paths "/usr/local/opt/python/libexec/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/bin" $fish_user_paths
eval (python -m virtualfish)

set -gx LDFLAGS "-L/usr/local/opt/php@7.2/lib"
set -gx CPPFLAGS "-I/usr/local/opt/php@7.2/include"

#set -x -g PATH /Users/luiscorreia/.composer/vendor/bin $PATH
#set -x -g "/usr/local/sbin"
#set -x -g PATH "/usr/local/opt/php@7.2/bin" $PATH
#set -x -g PATH "/usr/local/opt/php@7.2/sbin" $PATH
#set -x -g LDFLAGS "-L/usr/local/opt/php@7.2/lib"
#set -x -g CPPFLAGS "-I/usr/local/opt/php@7.2/include"

alias igocore="docker-compose -f docker-compose.common.yml -f docker-compose.dev.yml"
set -g fish_user_paths "/usr/local/opt/mysql-client/bin" $fish_user_paths
