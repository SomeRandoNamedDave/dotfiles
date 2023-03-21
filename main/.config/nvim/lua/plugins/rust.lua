return {
    { -- https://github.com/Saecki/crates.nvim
        'saecki/crates.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig'
        },
        event = 'BufReadPost Cargo.toml',
        -- TODO: setup keymaps
        config = function()
            local x = require('crates')
            x.setup(); x.reload()
        end
    }
}
