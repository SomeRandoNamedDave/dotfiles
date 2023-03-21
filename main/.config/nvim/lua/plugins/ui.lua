local diags = {
    [1] = { type = vim.diagnostic.severity.ERROR, icon = '󰅙', colour = FLAVOURS.base08 },
    [2] = { type = vim.diagnostic.severity.WARN, icon = '', colour = FLAVOURS.base0A },
    [3] = { type = vim.diagnostic.severity.INFO, icon = '', colour = FLAVOURS.base0C },
    [4] = { type = vim.diagnostic.severity.HINT, icon = '󱧡', colour = FLAVOURS.base0E }
}

return {
    { -- https://github.com/MunifTanjim/nui.nvim
        'MunifTanjim/nui.nvim',
        lazy = true
    },
    { -- https://github.com/rcarriga/nvim-notify
        'rcarriga/nvim-notify',
        lazy = true,
        opts = {
            on_open = function(win)
                if vim.api.nvim_win_is_valid(win) then
                    vim.api.nvim_win_set_config(win, { border = 'single' })
                end
            end,
            render = function(bufnr, notif, highlights, config)
                local api = vim.api
                local base = require('notify.render.base')

                local left_icon = notif.icon .. '  '
                local max_message_width = math.max(math.max(unpack(vim.tbl_map(function(line)
                    return vim.fn.strchars(line)
                end, notif.message))))
                local right_title = notif.title[2]
                local left_title = notif.title[1]
                local title_accum = vim.str_utfindex(left_icon)
                + vim.str_utfindex(right_title)
                + vim.str_utfindex(left_title)

                local left_buffer = string.rep(' ', math.max(0, max_message_width - title_accum))

                local namespace = base.namespace()
                api.nvim_buf_set_lines(bufnr, 0, 1, false, { '', '' })
                api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
                    virt_text = {{ ' ' }, { left_icon, highlights.icon }, { left_title .. left_buffer, highlights.title }},
                    virt_text_win_col = 0,
                    priority = 10
                })

                api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
                    virt_text = {{ ' ' }, { right_title, highlights.title }, { ' ' }},
                    virt_text_pos = 'right_align',
                    priority = 10
                })

                api.nvim_buf_set_extmark(bufnr, namespace, 1, 0, {
                    virt_text = {{
                        string.rep('─', math.max(vim.str_utfindex(left_buffer) + title_accum + 2, config.minimum_width())),
                        highlights.border
                    }},
                    virt_text_win_col = 0,
                    priority = 10
                })

                api.nvim_buf_set_lines(bufnr, 2, -1, false, notif.message)
                api.nvim_buf_set_extmark(bufnr, namespace, 2, 0, {
                    hl_group = highlights.body,
                    end_line = 1 + #notif.message,
                    end_col = #notif.message[#notif.message],
                    priority = 50
                })
            end,
            minimum_width = 50,
            max_width = 50,
            stages = 'slide',
            timeout = 3000,
            top_down = false
        }
    },
    { -- https://github.com/folke/which-key.nvim
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function()
            local wk = require('which-key')

            wk.setup({
                plugins = { spelling = { enabled = true }},
                key_labels = {
                    ['<leader>'] = 'SPC',
                    ['<space>'] = 'SPC',
                    ['<cr>'] = ' ',
                    ['<Tab>'] = ' ',
                    ['<S-Tab>'] = '[S]  ',
                    ['<M-h>'] = 'Alt+h',
                    ['<M-l>'] = 'Alt+l',
                    ['<M-j>'] = 'Alt+j',
                    ['<M-k>'] = 'Alt+k'
                    -- TODO: more to be added here later...
                },
                icons = { separator = '➜ ', group = '+ ' },
                window = { border = 'single' },
                layout = {
                    spacing = 10,
                    align = 'center'
                }
            })

            wk.register({
                ['['] = { name = 'Goto previous …' },
                [']'] = { name = 'Goto next …' },
                ['<leader>'] = {
                    name = 'Leader',
                    ['f'] = { name = 'Finder' },
                    ['p'] = { name = 'Plugins' }
                }
            })

            wk.register({ ['<leader>'] = { ['s'] = { name = 'Surround' }}}, { mode = { 'n', 'v' }})
        end
    },
    { -- https://github.com/andymass/vim-matchup
        'andymass/vim-matchup',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        event = 'BufReadPost',
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        end
    },
    { -- https://github.com/RRethy/vim-illuminate
        'RRethy/vim-illuminate',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        event = 'BufReadPost',
        config = function()
            require('illuminate').configure({
                providers = { 'lsp', 'treesitter' },
                delay = 50,
                min_count_to_highlight = 2
            })

            local function map(key, dir, buffer)
                vim.keymap.set('n', key, function()
                    require('illuminate')['goto_' .. dir .. '_reference'](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' reference', buffer = buffer })
            end

            map(']]', 'next')
            map('[[', 'prev')

            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map(']]', 'next', buffer)
                    map('[[', 'prev', buffer)
                end,
            })
        end,
        keys = {
            { ']]', desc = 'Next reference' },
            { '[[', desc = 'Prev reference' }
        }
    },
    { -- https://github.com/folke/zen-mode.nvim
        'folke/zen-mode.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        cmd = 'ZenMode',
        keys = {{ '<leader>z', '<cmd>ZenMode<cr>', desc = 'Toggle ZenMode' }},
        opts = {
            window = {
                backdrop = 0.95,
                width = 0.8
            },
            plugins = {
                gitsigns = { enabled = true },
                twilight = { enabled = false }
            },
            on_open = function(_)
                vim.wo.fcs = 'fold: ,eob: '
                require('lualine').hide({})
                vim.o.statusline = ' '
            end,
            on_close = function()
                require('lualine').hide({ unhide = true })
            end
        }
    },
    { -- https://github.com/echasnovski/mini.indentscope
        'echasnovski/mini.indentscope',
        event = 'BufReadPost',
        config = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'help', 'alpha', 'neo-tree', 'noice', 'lazy' },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end
            })
            require('mini.indentscope').setup({
                draw = {
                    delay = 50,
                    animation = function(_, _) return 10 end
                },
                options = { try_as_border = true },
                symbol = '┊'
            })
        end
    },
    { -- https://github.com/echasnovski/mini.animate
        'echasnovski/mini.animate',
        event = 'BufReadPost',
        config = function()
            local x = require('mini.animate')
            x.setup({
                cursor = {
                    timing = x.gen_timing.linear({ duration = 6, unit = 'step' }),
                    path = x.gen_path.spiral({ width = 3 })
                },
                scroll = { timing = x.gen_timing.linear({ duration = 150, unit = 'total' }) },
                resize = { enable = false },
                open = { enable = false },
                close = { enable = false }
            })
        end
    },
    { -- https://github.com/akinsho/bufferline.nvim
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = 'VeryLazy',
        config = function()
            require('bufferline').setup({
                options = {
                    numbers = 'none',
                    ---@diagnostic disable-next-line
                    right_mouse_command = nil,
                    middle_mouse_command = 'bdelete! %d',
                    indicator = { style = 'underline' },
                    modified_icon = '󰧞',
                    offsets = {{
                        filetype = 'neo-tree',
                        text = 'files',
                        highlight = 'BufferLineFileManager',
                        text_align = 'center',
                        padding = 1
                    }},
                    show_buffer_close_icons = false,
                    show_tab_indicators = false,
                    show_close_icon = false,
                    persist_buffer_sort = false,
                    ---@diagnostic disable-next-line
                    separator_style = { ' ', ' ' },
                    sort_by = 'id',
                    custom_areas = {
                        left = function()
                            local ro = vim.bo.readonly
                            if not ro or vim.bo.filetype == 'neo-tree' then return nil end
                            return {{
                                text = '   ',
                                fg = FLAVOURS.base08,
                                bg = 'none',
                                bold = true
                            }}
                        end,
                        right = function()
                            local R = {}
                            if not SHOW_LSP_INFO then return R end

                            local server = vim.lsp.get_active_clients({ bufnr = 0 })
                            if server ~= nil and #server > 0 then
                                table.insert(R, { text = '   ' .. server[1].name .. ' ', fg = FLAVOURS.base02 })
                                -- local modes = { [105] = true, [82] = true }
                                -- if modes[vim.fn.mode():byte()] then return R end
                                for i = 1,4,1 do
                                    local n = #vim.diagnostic.get(0, { severity = diags[i].type })
                                    if n ~= nil and n > 0 then
                                        table.insert(R, { text = ' ' .. diags[i].icon .. ' ' .. n, fg = diags[i].colour, bg = 'none' })
                                    end
                                end
                            end

                            return R
                        end
                    }
                },
                highlights = {
                    fill = {
                        fg = 'none',
                        bg = 'none'
                    },
                    background = {
                        fg = FLAVOURS.base02,
                        bg = 'none',
                        bold = true,
                        italic = true
                    },
                    buffer_visible = {
                        fg = FLAVOURS.base03,
                        bg = 'none',
                        bold = true,
                        italic = true
                    },
                    buffer_selected = {
                        fg = FLAVOURS.base06,
                        bg = 'none',
                        bold = true,
                        italic = true
                    },
                    modified = {
                        fg = FLAVOURS.base08,
                        bg = 'none'
                    },
                    modified_visible = {
                        fg = FLAVOURS.base08,
                        bg = 'none'
                    },
                    modified_selected = {
                        fg = FLAVOURS.base08,
                        bg = 'none'
                    },
                    separator_selected = {
                        fg = FLAVOURS.base01,
                        bg = 'none'
                    },
                    separator_visible = {
                        fg = FLAVOURS.base01,
                        bg = 'none'
                    },
                    separator = {
                        fg = FLAVOURS.base01,
                        bg = 'none'
                    },
                    indicator_selected = {
                        fg = FLAVOURS.base09,
                        bg = 'none'
                    }
                }
            })
        end
    },
    { -- https://github.com/nvim-lualine/lualine.nvim
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        config = function()
            local clear = {
                a = { fg = 'none', bg = 'none', gui = 'none', guisp = 'none' },
                b = { fg = 'none', bg = 'none', gui = 'none', guisp = 'none' },
                c = { fg = 'none', bg = 'none', gui = 'none', guisp = 'none' },
                x = { fg = 'none', bg = 'none', gui = 'none', guisp = 'none' },
                y = { fg = 'none', bg = 'none', gui = 'none', guisp = 'none' },
                z = { fg = 'none', bg = 'none', gui = 'none', guisp = 'none' }
            }

            local config = {
                options = {
                    theme = {
                        normal = clear,
                        insert = clear,
                        visual = clear,
                        replace = clear,
                        command = clear,
                        inactive = clear
                    },
                    component_separators = '',
                    section_separators = '',
                    disabled_buftypes = { statusline = { 'prompt' }},
                    disabled_filetypes = { statusline = { 'alpha', 'lazy', 'neo-tree', 'TelescopePrompt' }},
                    -- always_divide_middle = false,
                    globalstatus = true,
                    refresh = { statusline = 500 }
                },
                sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                }
            }

            local mode_color = function(mode)
                local mode_colors = {
                    [110] = FLAVOURS.base09,
                    [105] = FLAVOURS.base0B,
                    [99] = FLAVOURS.base02,
                    [116] = FLAVOURS.base0D,
                    [118] = FLAVOURS.base0E,
                    [22] = FLAVOURS.base0E,
                    [86] = FLAVOURS.base0E,
                    [82] = FLAVOURS.base08,
                    [115] = FLAVOURS.base08,
                    [83] = FLAVOURS.base08
                }

                local color = mode_colors[mode]
                if color ~= nil then
                    return color
                else
                    return FLAVOURS.base0E
                end
            end

            table.insert(config.sections.lualine_a, {
                function()
                    local mode = vim.fn.mode():byte()

                    local aliases = {
                        [110] = os.date('%H:%M'),
                        [105] = 'INSERT',
                        [99] = 'COMMAND',
                        [116] = 'TERMINAL',
                        [118] = 'VISUAL',
                        [22] = 'V-BLOCK',
                        [86] = 'V-LINE',
                        [82] = 'REPLACE',
                        [115] = 'SELECT',
                        [83] = 'S-LINE'
                    }
                    local alias = aliases[mode]

                    local output
                    if alias ~= nil then
                        output = alias
                    else
                        output = mode
                    end

                    return '  ' .. output .. '  '
                end,
                icons_enabled = false,
                color = function()
                    return {
                        fg = FLAVOURS.base07,
                        bg = mode_color(vim.fn.mode():byte()),
                        gui = 'bold'
                    }
                end,
                padding = 0
            })

            table.insert(config.sections.lualine_b, {
                function()
                    for i = 1,4,1 do
                        local result = vim.diagnostic.get(0, { severity = diags[i].type })
                        if result ~= nil and #result > 0 then
                            local message = ' ' .. result[1].lnum + 1 .. ':' .. result[1].col + 1 .. ' ➜  ' .. diags[i].icon

                            local limit = (vim.api.nvim_win_get_width(0) / 2) - 27
                            if limit < 6 then return message end

                            local append = '  ' .. result[1].message
                            if #append < limit then return message .. append end

                            return message .. string.sub(append, 1, limit - 2) .. '…'
                        end
                    end
                end,
                icons_enabled = false,
                cond = function()
                    if SHOW_LSP_INFO then
                        local x = vim.diagnostic.get(0)
                        if x ~= nil and #x > 0 then return true end
                    end
                    return false
                end,
                color = function()
                    for i = 1,4,1 do
                        local x = vim.diagnostic.get(0, { severity = diags[i].type })
                        if x ~= nil and #x > 0 then
                            return { fg = diags[i].colour }
                        end
                    end
                    return clear.b
                end,
                padding = 2
            })

            table.insert(config.sections.lualine_x, {
                function()
                    local branch = vim.api.nvim_buf_get_var(0, 'gitsigns_head')
                    if string.len(branch) > 14 then
                        branch = string.sub(branch, 1, 12) .. '…'
                    end
                    return branch
                end,
                icons_enabled = true,
                icon = { '', align = 'left' },
                cond = function()
                    ---@diagnostic disable-next-line
                    if vim.b.gitsigns_head then
                        if vim.api.nvim_win_get_width(0) > 100 then return true end
                    end
                    return false
                end,
                color = { fg = FLAVOURS.base04 },
                padding = 1
            })

            table.insert(config.sections.lualine_x, {
                function()
                    return vim.api.nvim_buf_get_var(0, 'gitsigns_status_dict').added
                end,
                icons_enabled = true,
                icon = { '', align = 'left' },
                cond = function()
                    if vim.fn.exists('b:gitsigns_status_dict') == 1 then
                        local added = vim.api.nvim_buf_get_var(0, 'gitsigns_status_dict').added
                        if added ~= nil and added > 0 then
                            return true
                        end
                    end
                    return false
                end,
                color = { fg = FLAVOURS.base0B },
                padding = { left = 0, right = 1 }
            })

            table.insert(config.sections.lualine_x, {
                function()
                    return vim.api.nvim_buf_get_var(0, 'gitsigns_status_dict').changed
                end,
                icons_enabled = true,
                icon = { '', align = 'left' },
                cond = function()
                    if vim.fn.exists('b:gitsigns_status_dict') == 1 then
                        local changed = vim.api.nvim_buf_get_var(0, 'gitsigns_status_dict').changed
                        if changed ~= nil and changed > 0 then
                            return true
                        end
                    end
                    return false
                end,
                color = { fg = FLAVOURS.base0D },
                padding = { left = 0, right = 1 }
            })

            table.insert(config.sections.lualine_x, {
                function()
                    return vim.api.nvim_buf_get_var(0, 'gitsigns_status_dict').removed
                end,
                icons_enabled = true,
                icon = { '', align = 'left' },
                cond = function()
                    if vim.fn.exists('b:gitsigns_status_dict') == 1 then
                        local removed = vim.api.nvim_buf_get_var(0, 'gitsigns_status_dict').removed
                        if removed ~= nil and removed > 0 then
                            return true
                        end
                    end
                    return false
                end,
                color = { fg = FLAVOURS.base08 },
                padding = { left = 0, right = 1 }
            })

            local show_y = function()
                local n = 100
                ---@diagnostic disable-next-line
                if vim.b.gitsigns_head then n = 140 end
                if vim.api.nvim_win_get_width(0) > n then return true end
                return false
            end

            table.insert(config.sections.lualine_y, {
                function() return ' ' end,
                icons_enabled = false,
                cond = show_y,
                color = { bg = FLAVOURS.base01 },
                padding = 0
            })

            table.insert(config.sections.lualine_y, {
                'filesize',
                icons_enabled = false,
                cond = show_y,
                color = {
                    fg = FLAVOURS.base04,
                    bg = FLAVOURS.base01
                },
                padding = 1
            })

            table.insert(config.sections.lualine_y, {
                function() return vim.bo.filetype:upper() end,
                icons_enabled = false,
                cond = show_y,
                color = {
                    fg = FLAVOURS.base04,
                    bg = FLAVOURS.base01
                },
                padding = 1
            })

            table.insert(config.sections.lualine_y, {
                function() return vim.api.nvim_buf_line_count(0) .. ' ' end,
                icons_enabled = false,
                cond = show_y,
                color = {
                    fg = FLAVOURS.base04,
                    bg = FLAVOURS.base01
                },
                padding = 1
            })

            table.insert(config.sections.lualine_z, {
                function()
                    local pos = vim.api.nvim_win_get_cursor(0)
                    return string.format('  %3d : %2d ', pos[1], pos[2] + 1)
                end,
                icons_enabled = false,
                color = {
                    fg = FLAVOURS.base05,
                    bg = FLAVOURS.base02,
                    gui = 'bold'
                },
                padding = 1
            })

            require('lualine').setup(config)
        end
    },
    { -- https://github.com/folke/noice.nvim
        'folke/noice.nvim',
        event = 'VeryLazy',
        keys = {
            { '<c-f>', function() if not require('noice.lsp').scroll(4) then return '<c-f>' end end, silent = true, expr = true, desc = 'Scroll forward', mode = { 'i', 'n', 's' }},
            { '<c-b>', function() if not require('noice.lsp').scroll(-4) then return '<c-b>' end end, silent = true, expr = true, desc = 'Scroll backward', mode = { 'i', 'n', 's' }}
        },
        opts = {
            cmdline = {
                view = 'cmdline'
            },
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true
                },
                progress = { view = 'notify' }
            },
            popupmenu = { enabled = false },
            views = {
                confirm = { border = { style = 'single' }},
                hover = {
                    border = { style = 'single' },
                    position = { row = 2, col = 0 }
                },
                notify = { merge = true, replace = true },
                popup = { border = { style = 'single' }},
            }
        }
    },
    { -- https://github.com/goolord/alpha-nvim
        'goolord/alpha-nvim',
        cmd = 'Alpha',
        init = function()
            if vim.fn.argc() == 0
                and vim.api.nvim_win_get_width(0) > 69
                and vim.api.nvim_win_get_height(0) > 12
            then require('alpha') end
        end,
        config = function() require('dashboard').setup() end
    }
}
