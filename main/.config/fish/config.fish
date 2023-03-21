if status is-login
    printf '[H[2J[0m'
    ddate_update
    set -U fish_greeting

    # ENVIRONMENT VARIABLES
    ## basic
    for x in (find $HOME/.local/bin -type d)
        set -gx PATH $PATH $x
    end
    set -gx PATH $PATH $HOME/projects/testing
    set -gx TERMINAL wezterm
    set -gx VISUAL nvim
    set -gx EDITOR nvim
    set -gx BROWSER qutebrowser \
        --qt-flag ignore-gpu-blocklist \
        --qt-flag enable-gpu-rasterization \
        --qt-flag enable-native-gpu-memory-buffers \
        --qt-flag num-raster-threads=4 \
        --qt-flag enable-accelerated-video-decode \
        --qt-flag use-gl=desktop
    ## XDG
    set -gx XDG_CONFIG_HOME $HOME/.config
    set -gx XDG_CACHE_HOME $HOME/.cache
    set -gx XDG_DATA_HOME $HOME/.local/share
    set -gx XDG_STATE_HOME $HOME/.local/state
    set -gx XDG_DOWNLOAD_DIR $HOME/downloads
    set -gx XDG_MUSIC_DIR $HOME/music
    set -gx XDG_PICTURES_DIR $HOME/images
    set -gx XDG_VIDEOS_DIR $HOME/videos
    ## handy
    set -gx PRIVATE $HOME/.local/private
    set -gx SCRIPTS $HOME/.local/bin
    set -gx MTV $XDG_VIDEOS_DIR/music
    set -gx GAMES $XDG_DATA_HOME/games
    set -gx PROJECTS $HOME/projects
    set -gx DOTFILES $PROJECTS/dotfiles
    set -gx STARTPAGE $XDG_DATA_HOME/localweb/startpage
    set -gx WALLPAPERS $XDG_PICTURES_DIR/wallpapers
    ## home folder cleanup
    if test ! -f $XDG_RUNTIME_DIR/Xauthority
        touch $XDG_RUNTIME_DIR/Xauthority
    end
    set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
    set -gx GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0
    set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
    set -gx GOPATH $XDG_DATA_HOME/go
    set -gx ASPELL_CONF "per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_CONFIG_HOME/aspell/en.pws; repl $XDG_CONFIG_HOME/aspell/en.prepl"
    set -gx CARGO_HOME $XDG_DATA_HOME/cargo
    set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
    set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
    set -gx PYLINTHOME $XDG_CACHE_HOME/pylint
    set -gx WGETRC $XDG_CONFIG_HOME/wget/wgetrc
    set -gx CUDA_CACHE_PATH $XDG_CACHE_HOME/.nv
    set -gx STARSHIP_CONFIG $XDG_CONFIG_HOME/starship/config.toml
    ## application theming
    set -gx HIGHLIGHT_STYLE $XDG_CONFIG_HOME/highlight/flavours.theme
    set -gx HIGHLIGHT_TABWIDTH 4
    set -gx EXA_ICON_SPACING '2'
    set -gx GREP_COLORS 'mt=4;36'
    set -gx LESSHISTFILE $XDG_DATA_HOME/less/less.hist
    set -gx LESSHISTSIZE 1000
    set -gx LESS -iR
    set -gx LESS_TERMCAP_mb \e\[0\x3B44\x3B97m  ## - begin blink
    set -gx LESS_TERMCAP_md \e\[1\x3B36m        ## - begin bold
    set -gx LESS_TERMCAP_me \e\[0m		        ## - reset bold/blink
    set -gx LESS_TERMCAP_so \e\[0\x3B42\x3B97m	## - begin reverse video
    set -gx LESS_TERMCAP_se \e\[0m		        ## - reset reverse video
    set -gx LESS_TERMCAP_us \e\[4\x3B35m	    ## - begin underline
    set -gx LESS_TERMCAP_ue \e\[0m		        ## - reset underline
    ## other
    set -gx QT_QPA_PLATFORMTHEME 'qt5ct'
    set -gx QT_QPA_PLATFORM_PLUGIN_PATH /usr/lib/qt/plugins
    # set -gx NVIM_LISTEN_ADDRESS /tmp/nvim

    if test (tty) = '/dev/tty1'
        if ! pgrep -x awesome >/dev/null
            exec startx $XDG_CONFIG_HOME/X11/xinitrc
        end
    end
end

if status is-interactive
    zoxide init fish | source
    starship init fish | source
end
