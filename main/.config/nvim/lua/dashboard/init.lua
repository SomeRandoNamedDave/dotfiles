local M = {}

local alpha = require('alpha')
local redraw = alpha.redraw
local lazy_stats = require('lazy').stats

local function button(key, txt, cmd)
    local opts = {
        position = 'center',
        text = txt,
        shortcut = key,
        cursor = 17,
        width = 18,
        align_shortcut = 'right',
        hl_shortcut = 'AlphaShortcut',
        hl = 'AlphaButtons'
    }

    if cmd then
        opts.keymap = { 'n', key, cmd, { noremap = true, silent = true }}
    end

    return {
        type = 'button',
        val = txt,
        on_press = function()
            local _key = vim.api.nvim_replace_termcodes(key, true, false, true)
            vim.api.nvim_feedkeys(_key, 'normal', false)
        end,
        opts = opts,
    }
end

local buttons = {
    type = 'group',
    val = {
        button('e', '  New', '<cmd>ene<cr>'),
        button('f', '  Find', '<cmd>Telescope find_files<cr>'),
        button('r', '  Recent', '<cmd>Telescope oldfiles<cr>'),
        button('u', '  Update', '<cmd>Lazy sync<cr>'),
        button('q', '  Quit!', '<cmd>qall!<cr>')
    },
    opts = { spacing = 1 }
}

function M.layout()
    local R = {}

    R.pid = vim.loop.getpid()
    R.width = vim.api.nvim_win_get_width(0)
    R.height = vim.api.nvim_win_get_height(0)

    local image_pad
    local show_image

    if R.height < 34 then
        image_pad = (math.floor(bit.arshift(R.height, 1)) - 4)
        show_image = false
    else
        image_pad = (math.floor(R.height * 0.75) - 3)
        show_image = true
    end

    R.image_pad = image_pad
    R.show_image = show_image

    R.display = {
        { type = 'padding', val = R.image_pad },
        buttons
    }

    if R.height > 18 then
        local function today()
            local day = os.date('%e'):gsub('%s', '')
            local function suffix()
                if day:match('1$') then return 'st'
                elseif day:match('2$') then return 'nd'
                elseif day:match('3$') then return 'rd'
                else return 'th'
                end
            end
            return day .. suffix()
        end

        local stats_val = '  ' .. os.date('%A') .. ' ' .. today() .. ' ' .. os.date('%B')
        if vim.g.did_very_lazy then
            local stats = lazy_stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            stats_val = stats_val .. '  |  󰒲  ' .. stats.count .. ' plugins loaded in ' .. ms .. 'ms'
        end

        table.insert(R.display, { type = 'padding', val = 3 })
        table.insert(R.display, {
            type = 'text',
            val = stats_val,
            opts = { position = 'center', hl = 'AlphaFooter' }
        })
    end

    return R
end

function M.setup()
    local function config()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'LazyVimStarted',
            once = true,
            callback = function()
                vim.api.nvim_create_autocmd('User', {
                    -- INFO: the line below needs to be added to the end of alpha.draw() in alpha.lua
                    -- vim.api.nvim_exec_autocmds("User", { pattern = "AlphaRendered" })
                    pattern = 'AlphaRendered',
                    callback = function()
                        vim.cmd('mod')
                        local state = M.layout()
                        if state.show_image then
                            vim.defer_fn(function()
                                local cursor_pos = vim.api.nvim_win_get_cursor(0)
                                local redirect = ' > /proc/' .. state.pid .. '/fd/1'
                                local chafa_cmd = 'chafa -C true -f sixel -w 9 -s '
                                chafa_cmd = chafa_cmd .. state.width .. 'x' .. math.floor(bit.arshift(state.height, 1))
                                chafa_cmd = chafa_cmd .. ' ~/.config/nvim/lua/dashboard/ellie.png' .. redirect

                                pcall(os.execute, [[printf '[3H']] .. redirect)
                                pcall(os.execute, chafa_cmd)
                                require('dashboard.puns').print(state.width, redirect)
                                pcall(os.execute, [[printf '[]] .. (cursor_pos[1] + 1) .. ';' .. (cursor_pos[2] - 1) .. [[H']] .. redirect)
                            end, 25)
                        end
                    end
                })

                local stats = lazy_stats()
                local tbl = package.loaded.alpha.default_config.layout
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                ---@diagnostic disable-next-line
                tbl[#tbl].val = tbl[#tbl].val .. '  |  󰒲  ' .. stats.count .. ' plugins loaded in ' .. ms .. 'ms'
                redraw()
            end
        })

        vim.api.nvim_create_autocmd('User', {
            pattern = 'AlphaReady',
            callback = function()
                vim.o.stal = 0
                vim.b.miniindentscope_disable = true

                local buf = vim.api.nvim_get_current_buf()
                local win = vim.api.nvim_get_current_win()

                vim.keymap.set('n', '<c-l>', function()
                    package.loaded.alpha.default_config.layout = M.layout().display
                    redraw()
                end, { noremap = true, silent = true, buffer = buf, desc = 'Refresh dashboard' })

                local augroup = vim.api.nvim_create_augroup('alpha_recalc', { clear = true })

                vim.api.nvim_create_autocmd('VimResized', {
                    group = augroup,
                    buffer = buf,
                    callback = function()
                        package.loaded.alpha.default_config.layout = M.layout().display
                        if vim.api.nvim_get_current_win() == win then
                            redraw()
                        end
                    end
                })

                vim.api.nvim_create_autocmd({ 'WinEnter' }, {
                    group = augroup,
                    buffer = buf,
                    callback = function()
                        vim.defer_fn(function()
                            if vim.api.nvim_get_current_win() == win then
                                redraw()
                            end
                        end, 5)
                    end
                })

                vim.api.nvim_create_autocmd('User', {
                    pattern = 'AlphaClosed',
                    callback = function()
                        vim.o.stal = 2
                        vim.api.nvim_del_augroup_by_id(augroup)
                    end
                })
            end
        })
    end

    local opts = {
        layout = M.layout().display,
        opts = {
            margin = 0,
            redraw_on_resize = false,
            setup = config()
        }
    }

    alpha.setup(opts)
end

return M
