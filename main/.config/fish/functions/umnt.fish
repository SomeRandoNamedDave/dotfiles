function umnt --wraps='sudo umount -R /mnt' --description 'unmount external HDD'
    if test (pwd) = /mnt*; cd $HOME; end
    sudo umount -R /mnt
end
