return {
    { -- https://github.com/L3MON4D3/LuaSnip
        'L3MON4D3/LuaSnip',
        lazy = true,
        build = 'make install_jsregexp'
    },
    { -- https://github.com/mtoohey31/cmp-fish
        'mtoohey31/cmp-fish',
        dependencies = 'hrsh7th/nvim-cmp',
        ft = 'fish'
    },
    { -- https://github.com/hrsh7th/nvim-cmp
        'hrsh7th/nvim-cmp',
        dependencies = {
            'windwp/nvim-autopairs',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            'onsails/lspkind.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            'hrsh7th/cmp-emoji',
            'ray-x/cmp-treesitter',
            'lukas-reineke/cmp-rg',
            'f3fora/cmp-spell',
            'chrisgrieser/cmp-nerdfont',
            'dmitmel/cmp-cmdline-history'
        },
        event = 'InsertEnter',
        keys = {{ ':' }, { '/' }, { '?' }},
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                view = { entries = { name = 'custom', selection_order = 'near_cursor' }},
                window = {
                    completion = {
                        border = 'single',
                        col_offset = 0,
                        side_padding = 0,
                        winhighlight = 'Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None'
                    },
                    documentation = {
                        border = 'single',
                        winhighlight = 'Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None'
                    }
                },
                mapping = cmp.mapping.preset.insert({
                    ['<c-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<c-f>'] = cmp.mapping.scroll_docs(4),
                    ---@diagnostic disable-next-line
                    ['<c-space>'] = cmp.mapping.complete(),
                    ['<cr>'] = cmp.mapping.confirm({ select = false }),
                    ['<tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<s-tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' })
                }),
                formatting = {
                    fields = { 'abbr', 'kind', 'menu' },
                    format = function(entry, vim_item)
                        if vim.tbl_contains({ 'path' }, entry.source.name) then
                            local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
                            if icon then
                                vim_item.kind = ' ' .. icon .. ' '
                                vim_item.kind_hl_group = hl_group
                                return vim_item
                            end
                        end
                        vim_item.menu = ({
                            nvim_lsp = '',
                            path = '',
                            luasnip = '',
                            nvim_lua = '',
                            fish = '󰈺',
                            crates = '🦀',
                            buffer = '',
                            treesitter = '',
                            emoji = '󰞅',
                            nerdfont = '',
                            spell = '﬜',
                            rg = '',
                            cmdline = '',
                            nvim_lsp_document_symbol = '',
                            cmdline_history = ''
                        })[entry.source.name]
                        local kind = require('lspkind').cmp_format({
                            ellipsis_char = '…',
                            maxwidth = 50,
                            mode = 'symbol_text'
                        })(entry, vim_item)
                        kind.kind = ' ' .. kind.kind .. ' '
                        return kind
                    end
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'luasnip' },
                    { name = 'nvim-lua' },
                    { name = 'fish' },
                    { name = 'crates' },
                    { name = 'buffer' },
                    { name = 'treesitter' },
                    { name = 'emoji' },
                    { name = 'nerdfont' },
                    { name = 'spell' },
                    { name = 'rg' }
                })
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'cmdline' },
                    { name = 'path' },
                    { name = 'cmdline_history' }
                })
            })

            for _, x in ipairs({'/', '?'}) do
                cmp.setup.cmdline(x, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = 'nvim_lsp_document_symbol' },
                        { name = 'buffer' },
                        { name = 'cmdline_history' }
                    })
                })
            end

            cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
        end
    }
}
