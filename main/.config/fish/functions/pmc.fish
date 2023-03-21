function pmc --wraps='sudo pacman -Rns (pacman -Qtdq)' --description 'pacman clean'
    set -l orphans (pacman -Qtdq)
    if ! test -z "$orphans"
        sudo pacman -Rns -- $orphans
    else
        printf "[1;32m  [0mNothing to remove!\n"
    end
end
