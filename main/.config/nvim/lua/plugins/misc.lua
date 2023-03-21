return {
    { -- https://github.com/nvim-tree/nvim-web-devicons
        'nvim-tree/nvim-web-devicons', lazy = true
    },
    { -- https://github.com/folke/todo-comments.nvim
        'folke/todo-comments.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter'
        },
        event = 'BufReadPost',
        config = function()
            require('todo-comments').setup({})

            vim.keymap.set('n', ']t', function()
                require('todo-comments').jump_next()
            end, { desc = 'Next todo comment' })

            vim.keymap.set('n', ']T', function()
                require('todo-comments').jump_next({ keywords = { 'ERROR', 'WARNING' }})
            end, { desc = 'Next error/warning comment' })

            vim.keymap.set('n', '[t', function()
                require('todo-comments').jump_prev()
            end, { desc = 'Previous todo comment' })

            vim.keymap.set('n', '[T', function()
                require('todo-comments').jump_prev({ keywords = { 'ERROR', 'WARNING' }})
            end, { desc = 'Previous error/warning  comment' })
        end
    }
}
