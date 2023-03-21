function rmpd --wraps=mpc --description 'reset mpd playlist'
    mpc -q update
    mpc -q clear
    mpc -q add /
    mpc -q update
    mpc -q play 1
    mpc -q stop
end
