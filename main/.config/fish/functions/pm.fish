function pm --wraps='sudo pacman' --description 'sudo pacman'
    sudo pacman $argv
end
