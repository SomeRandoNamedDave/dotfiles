return {{ -- https://github.com/lewis6991/gitsigns.nvim
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPost',
    opts = {
        signs = {
            add          = { hl = 'GitSignsAdd'   , text = '▐', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn' },
            change       = { hl = 'GitSignsChange', text = '▐', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
            delete       = { hl = 'GitSignsDelete', text = '✘', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
            topdelete    = { hl = 'GitSignsDelete', text = '✘', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
            changedelete = { hl = 'GitSignsChange', text = '▐', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' }
        },
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, key, cmd, desc)
                vim.keymap.set(mode, key, cmd, { buffer = buffer, desc = desc })
            end

            map('n', '[h', gs.prev_hunk, 'Previous hunk')
            map('n', ']h', gs.next_hunk, 'Next hunk')
            map('n', '<leader>gc', require('telescope.builtin').git_bcommits, 'Commits')
            map('n', '<leader>gd', gs.diffthis, 'Diff this')
            map('n', '<leader>gD', function() gs.diffthis('~') end, 'Diff this (~)')
            map('n', '<leader>gi', require('telescope.builtin').git_status, 'Status')
            map('n', '<leader>gl', function() gs.blame_line({ full = true }) end, 'Blame (line)')
            map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
            map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<cr>', 'Reset hunk')
            map('n', '<leader>gR', gs.reset_buffer, 'Reset buffer')
            map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<cr>', 'Stage hunk')
            map('n', '<leader>gu', gs.undo_stage_hunk, 'Undo stage hunk')
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<cr>', 'Gitsigns select hunk')

            require('which-key').register({ ['g'] = { name = 'Git' }}, { buffer = buffer,  mode = { 'n', 'v' }, prefix = '<leader>' })
        end
    }
}}
