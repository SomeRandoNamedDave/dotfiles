return {{ -- https://github.com/nvim-treesitter/nvim-treesitter
    'nvim-treesitter/nvim-treesitter',
    event = 'BufRead',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'bash',
                'c',
                'cmake',
                'cpp',
                'css',
                'dockerfile',
                'fish',
                'go',
                'html',
                'javascript',
                'json',
                'latex',
                'lua',
                'make',
                'markdown',
                'markdown_inline',
                'perl',
                'php',
                'python',
                'query',
                'rasi',
                'regex',
                'rust',
                'scss',
                'toml',
                'typescript',
                'vim',
                'yaml'
            },
            highlight = { enable = true, additional_vim_regex_highlighting = false },
            indent = { enable = true },
            matchup = { enable = true }
        })
        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end
}}
