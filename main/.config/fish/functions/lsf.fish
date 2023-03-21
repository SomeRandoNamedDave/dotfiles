function lsf --wraps='exa -alh --time-style=default --color=auto --group-directories-first --git --icons' --description 'exa formatted'
    exa -alh --time-style=default --color=auto --group-directories-first --git --icons $argv
end
