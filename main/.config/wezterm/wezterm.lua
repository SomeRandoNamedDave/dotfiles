require('flavours')
local w = require('wezterm')

return {
    default_prog = { '/usr/bin/fish' },
    -- automatically_reload_config = false,

    -- appearance
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    window_background_opacity = 0.92,
    window_frame = {
        font = w.font({ family = 'Iosevka Nerd Font', weight = 'Bold' }),
        font_size = 11.0
    },

    -- colours
    bold_brightens_ansi_colors = false,
    colors = {
        foreground = FLAVOURS.base05,
        background = FLAVOURS.base00,
        cursor_bg = FLAVOURS.base09,
        cursor_fg = FLAVOURS.base07,
        cursor_border = FLAVOURS.base09,
        ansi = {
            FLAVOURS.base00,
            FLAVOURS.base08,
            FLAVOURS.base0B,
            FLAVOURS.base0A,
            FLAVOURS.base0D,
            FLAVOURS.base0E,
            FLAVOURS.base0C,
            FLAVOURS.base05
        },
        brights = {
            FLAVOURS.base03,
            FLAVOURS.base08,
            FLAVOURS.base0B,
            FLAVOURS.base0A,
            FLAVOURS.base0D,
            FLAVOURS.base0E,
            FLAVOURS.base0C,
            FLAVOURS.base07
        },
        indexed = {
            [16] = FLAVOURS.base09,
            [17] = FLAVOURS.base0F,
            [18] = FLAVOURS.base01,
            [19] = FLAVOURS.base02,
            [20] = FLAVOURS.base04,
            [21] = FLAVOURS.base06
        }
    },

    -- font configuration
    adjust_window_size_when_changing_font_size = false,
    freetype_load_target = 'Light',
    font = w.font('Iosevka Nerd Font'),
    font_rules = {
        {
            italic = true,
            intensity = 'Bold',
            font = w.font('Victor Mono Nerd Font', { weight = 'Bold', italic = true })
        },
        {
            italic = true,
            font = w.font('Victor Mono Nerd Font', { italic = true })
        }
    },
    font_size = 13.2,
    underline_position = '175%',
    underline_thickness = '3px'
}
