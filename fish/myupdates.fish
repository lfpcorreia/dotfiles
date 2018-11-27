#!/usr/bin/env fish

function myupdates
    echo 'start updating ...'

    echo 'updating homebrew'
    brew update
    brew upgrade
    brew cleanup

    echo 'updating fish shell'
    fish_update_completions

    echo 'checking Apple Updates'
    /usr/sbin/softwareupdate -ia
end


