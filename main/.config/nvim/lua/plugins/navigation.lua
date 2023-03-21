return {
    { -- https://github.com/nvim-neo-tree/neo-tree.nvim
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim'
        },
        cmd = 'Neotree',
        keys = {{
            '<F1>',
            function() require('neo-tree.command').execute({ toggle = true, dir = require('base.utils').get_root() }) end,
            mode = 'n',
            desc = 'Toggle file manager'
        }},
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            if vim.fn.argc() == 1 then
                ---@diagnostic disable-next-line
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == 'directory' then
                    require('neo-tree')
                end
            end
        end,
        opts = {
            popup_border_style = 'single',
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = true
            },
            event_handlers = {
                {
                    event = 'file_opened',
                    handler = function(_) require('neo-tree').close_all() end
                },
                {
                    event = 'neo_tree_buffer_enter',
                    handler = function() vim.cmd([[highlight! CursorNormal blend=100]]) end
                },
                {
                    event = 'neo_tree_window_after_close',
                    handler = function()
                        require('theme.highlights').highlight.CursorNormal = { guifg = FLAVOURS.base00, guibg = FLAVOURS.base09, gui = nil, guisp = nil, blend = 0 }
                    end
                }
            },
            window = { mappings = { ['<space>'] = 'none' }}
        }
    },
    { -- https://github.com/nvim-telescope/telescope.nvim
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'tsakirist/telescope-lazy.nvim'
        },
        cmd = 'Telescope',
        keys = {
            { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command history' },
            { '<leader>/', require('base.utils').telescope('live_grep'), desc = 'ripgrep' },
            { '<leader><space>', require('base.utils').telescope('files'), desc = 'Find files in project' },
            { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Switch buffer' },
            { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = 'LSP diagnostics' },
            { '<leader>ff', require('base.utils').telescope('files', { cwd = false }), desc = 'Find files in cwd' },
            { '<leader>fn', '<cmd>Telescope notify<cr>', desc = 'Notifications' },
            { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
            { '<leader>fs', require('base.utils').telescope('lsp_document_symbols', { symbols = {
                'Class',
                'Function',
                'Method',
                'Constructor',
                'Interface',
                'Module',
                'Struct',
                'Trait',
                'Field',
                'Property'
            }}), desc = 'Goto symbol' },
            { '<leader>ft', '<cmd>TodoTelescope<cr>', desc = 'Find TODO comments' },
            { '<leader>fw', require('base.utils').telescope('grep_string'), desc = 'Find word in project' },
            { '<leader>fW', require('base.utils').telescope('grep_string', { cwd = false }), desc = 'Find word in cwd' }
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    sorting_strategy = 'ascending',
                    prompt_prefix = '   ',
                    selection_caret = '▋ ',
                    multi_icon = '󱇬 ',
                    borderchars = {
                        prompt  = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
                        results = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
                        preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }
                    },
                    dynamic_preview_title = true,
                    results_title = false,
                    layout_strategy = 'flex',
                    layout_config = {
                        flex = { flip_columns = 180 },
                        horizontal = {
                            height = 0.9,
                            width = 0.9,
                            preview_width = 0.7,
                            prompt_position = 'top'
                        },
                        vertical = {
                            height = 0.9,
                            width = 0.9,
                            preview_height = 0.7,
                            preview_cutoff = 20,
                            prompt_position = 'top'
                        }
                    },
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '--trim'
                    }
                },
                pickers = { find_files = {
                    find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' }
                }}
            })
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('lazy')
            require('telescope').load_extension('notify')
            require('telescope').load_extension('todo-comments')
        end
    },
    { -- https://github.com/ggandor/leap.nvim
        'ggandor/leap.nvim',
        dependencies = {
            { 'ggandor/flit.nvim', opts = { labeled_modes = 'nv' }},
            { 'tpope/vim-repeat' }
        },
        keys = {
            { 's', desc = 'Leap forward to', mode = { 'n', 'x', 'o' }},
            { 'S', desc = 'Leap backward to', mode = { 'n', 'x', 'o' }},
            { 'f', desc = 'Move to next char', mode = { 'n', 'v' }},
            { 'F', desc = 'Move to previous char', mode = { 'n', 'v' }},
            { 't', desc = 'Move before next char', mode = { 'n', 'v' }},
            { 'T', desc = 'Move before previous char', mode = { 'n', 'v' }}
        },
        config = function(_, opts)
            local leap = require('leap')
            for k, v in pairs(opts) do leap.opts[k] = v end
            leap.add_default_mappings(true)
        end
    }
}
