return {
    { -- https://github.com/windwp/nvim-autopairs
        'windwp/nvim-autopairs',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        event = 'InsertEnter',
        opts = { check_ts = true }
    },
    { -- https://github.com/echasnovski/mini.comment
        'echasnovski/mini.comment',
        event = 'BufReadPost',
        config = function() require('mini.comment').setup({
            ignore_blank_line = true
        }) end
    },
    { -- https://github.com/echasnovski/mini.surround
        'echasnovski/mini.surround',
        keys = function(plugin, keys)
            local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
            local mappings = {
                { opts.mappings.add, desc = 'Add surround', mode = { 'n', 'v' }},
                { opts.mappings.delete, desc = 'Delete surround' },
                { opts.mappings.find, desc = 'Find right surround' },
                { opts.mappings.find_left, desc = 'Find left surround' },
                { opts.mappings.highlight, desc = 'Highlight surround' },
                { opts.mappings.replace, desc = 'Replace surround' },
                { opts.mappings.update_n_lines, desc = 'Update `n` lines value' }
            }
            return vim.list_extend(mappings, keys)
        end,
        opts = { mappings = {
            add = '<leader>sa',
            delete = '<leader>sd',
            find = '<leader>sf',
            find_left = '<leader>sF',
            highlight = '<leader>sh',
            replace = '<leader>sr',
            update_n_lines = '<leader>sn'
        }},
        config = function(_, opts) require('mini.surround').setup(opts) end
    },
    { -- https://github.com/echasnovski/mini.align
        'echasnovski/mini.align',
        keys = {
            { 'ga', desc = 'Align text', mode = '' },
            { 'gA', desc = 'Align text (with preview)', mode = '' }
        },
        config = function() require('mini.align').setup() end
    },
    { -- https://github.com/echasnovski/mini.move
        'echasnovski/mini.move',
        event = 'VeryLazy',
        config = function() require('mini.move').setup() end
    }
}
