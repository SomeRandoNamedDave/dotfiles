-- globals, options, keymaps, autocommands
require('base')

-- lazy bootstrap, plugin spec
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
    ui = { border = 'single' },
    -- checker = { enabled = true },
    change_detection = { enabled = false, notify = false },
    install = { colorscheme = { 'flavours' }},
    performance = { rtp = { disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin'
    }}}
})
