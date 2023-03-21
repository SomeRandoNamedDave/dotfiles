vim.g.mapleader = [[ ]]
vim.keymap.set({ '', '!' }, '<F1>', '<nop>', { noremap = true, silent = true })

local function map(mode, key, cmd, desc)
    vim.keymap.set(mode, key, cmd, { noremap = true, silent = true, desc = desc })
end

-- editor keys
map('n', '<tab>', '<cmd>bn<cr>', 'Next buffer')
map('n', '<s-tab>', '<cmd>bp<cr>', 'Previous buffer')
map('n', '<leader>e', '<cmd>e!<cr>', 'Reload buffer')
map('n', '<leader>h', '<cmd>noh<cr>', 'Hide current match highlight')
map('n', '<leader>H', '<cmd>set hlsearch!<cr>', 'Toggle match highlighting')
map('n', '<leader>q', '<cmd>q<cr>', 'Safe quit')
map('n', '<leader>Q', '<cmd>q!<cr>', 'Quit')
map('n', '<leader>r', '<cmd>wq<cr>', 'Save & quit')
map('n', '<leader>w', '<cmd>w<cr>', 'Save current buffer')
map('n', '<leader>x', '<cmd>bd<cr>', 'Safe close buffer')
map('n', '<leader>X', '<cmd>bd!<cr>', 'Close buffer')

-- surround keys
map('v', '<leader>sq', [[:s/"/'/g | noh<cr>]], 'Quote swap (d/s)')
map('v', '<leader>sQ', [[:s/'/"/g | noh<cr>]], 'Quote swap (s/d)')

-- lazy keys
map('n', '<leader>pc', '<cmd>Lazy check<cr>', 'Check for updates')
map('n', '<leader>pC', '<cmd>Lazy clean<cr>', 'Clean removed plugins')
map('n', '<leader>pd', '<cmd>Lazy debug<cr>', 'Show debug information')
map('n', '<leader>pD', '<cmd>Lazy clear<cr>', 'Clear finished tasks')
map('n', '<leader>ph', '<cmd>Lazy health<cr>', 'Run health check')
map('n', '<leader>pi', '<cmd>Lazy install<cr>', 'Install missing plugins')
map('n', '<leader>pl', '<cmd>Lazy<cr>', 'Open Lazy')
map('n', '<leader>pL', '<cmd>Lazy log<cr>', 'Show recent updates')
map('n', '<leader>pp', '<cmd>Lazy profile<cr>', 'Show profiling information')
map('n', '<leader>pR', '<cmd>Lazy restore<cr>', 'Restore lockfile state')
map('n', '<leader>ps', '<cmd>Lazy sync<cr>', 'Sync all plugins')
map('n', '<leader>pt', '<cmd>Telescope lazy<cr>', 'View in Telescope')
map('n', '<leader>pu', '<cmd>Lazy update<cr>', 'Update all plugins')
