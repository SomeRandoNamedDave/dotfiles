return {
    { -- https://github.com/folke/neodev.nvim
        'folke/neodev.nvim',
        lazy = true
    },
    { -- https://github.com/neovim/nvim-lspconfig
        'neovim/nvim-lspconfig',
        dependencies = 'hrsh7th/nvim-cmp',
        event = {
            'BufReadPost Cargo.toml',
            'BufReadPost go.mod'
        },
        ft = {
            'go',
            'lua',
            'python',
            'rust',
            'sh'
        },
        config = function()
            local signs = { Error = '󰅙 ', Warn = ' ', Info = ' ', Hint = '󱧡 ' }
            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config({
                float = {
                    focusable = false,
                    style = 'minimal',
                    border = 'single',
                },
                severity_sort = true,
                virtual_text = false
            })

            local function lsp_keys(bufnr)
                local function map(key, cmd, desc)
                    vim.keymap.set('n', key, cmd, { noremap = true, silent = true, buffer = bufnr, desc = desc })
                end

                map('<c-k>', vim.lsp.buf.signature_help, 'Show signature help')
                map('[d', vim.diagnostic.goto_prev, 'Previous diagnostic notification')
                map(']d', vim.diagnostic.goto_next, 'Next diagnostic notification')
                map('gd', vim.lsp.buf.definition, 'Jump to definition')
                map('gD', vim.lsp.buf.declaration, 'Jump to declaration')
                map('gi', vim.lsp.buf.implementation, 'Jump to implementation')
                map('gl', vim.diagnostic.open_float, 'Line diagnostics popup')
                map('gr', vim.lsp.buf.references, 'Jump to references')
                map('gt', vim.lsp.buf.type_definition, 'Jump to type definition')
                map('K', vim.lsp.buf.hover, 'Show hover info')
                map('<leader>la', vim.lsp.buf.code_action, 'Code action')
                map('<leader>lf', function() vim.lsp.buf.format({ async = true }) end, 'Format document')
                map('<leader>lr', vim.lsp.buf.rename, 'Rename symbol')

                require('which-key').register({ ['l'] = { name = 'LSP' }}, { buffer = bufnr,  mode = 'n', prefix = '<leader>' })
            end

            local on_attach = function(_, bufnr)
                lsp_keys(bufnr)
                SHOW_LSP_INFO = true
            end

            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

            if vim.api.nvim_buf_get_name(0):find('/nvim/') then
                require('neodev').setup({})
            end

            local lsp = require('lspconfig')

            lsp.lua_ls.setup {
                cmd = { 'lua-language-server', '-E', '/usr/share/lua-language-server/main.lua' },
                single_file_support = true,
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false }
                    }
                },
                on_attach = on_attach,
                capabilities = capabilities
            }

            lsp.rust_analyzer.setup {
                on_attach = on_attach,
                capabilities = capabilities
            }

            lsp.bashls.setup {
                filetypes = { 'sh', 'zsh' },
                on_attach = on_attach,
                capabilities = capabilities
            }

            lsp.gopls.setup {
                on_attach = on_attach,
                capabilities = capabilities
            }

            lsp.pyright.setup {
                on_attach = on_attach,
                capabilities, capabilities
            }
        end
    }
}
