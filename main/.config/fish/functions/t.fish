function t --description 'toggle transmission service'
    if test (systemctl status transmission | awk 'NR==3{print $2}') = 'inactive'
        systemctl start transmission
    else
        systemctl stop transmission
    end
end
