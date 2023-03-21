function p --wraps=paru --description 'full system update'
    paru --devel -Syu $argv
end
