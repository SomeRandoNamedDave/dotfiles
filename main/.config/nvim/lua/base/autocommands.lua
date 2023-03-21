vim.api.nvim_create_augroup('_general_settings', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = '_general_settings',
    pattern = '*',
    callback = function() require('vim.highlight').on_yank({ higroup = 'search', timeout = 200 }) end
})
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufRead', 'BufNewFile' }, {
    group = '_general_settings',
    pattern = '*',
    command = 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o'
})
