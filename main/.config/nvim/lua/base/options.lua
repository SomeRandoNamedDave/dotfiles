for _, x in pairs({ 'node', 'perl', 'python3', 'ruby' }) do
  vim.g[string.format('loaded_%s_provider', x)] = 0
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

opt('o', 'tgc', true)
vim.cmd.colorscheme('flavours')
opt('o', 'title', true)

opt('o', 'ut', 50)
vim.g.cursorhold_updatetime = 50
opt('o', 'tm', 300)

opt('o', 'backup', false)
opt('o', 'wb', false)
opt('o', 'swf', false)
opt('b', 'udf', true)

opt('o', 'hid', true)
opt('o', 'history', 1000)
opt('o', 'clipboard', 'unnamedplus')
opt('o', 'mouse', 'a')

opt('o', 'ignorecase', true)
opt('o', 'scs', true)
opt('o', 'cot', 'menu,menuone,noselect')

opt('o', 'ls', 3)
opt('o', 'ch', 0)
opt('o', 'fcs', 'fold: ,eob: ')
opt('o', 'gcr', 'a:block,n-c:CursorNormal,i-ci-sm:CursorInsert,v-ve:CursorVisual,r-cr:CursorReplace,o:CursorOther')
opt('o', 'so', 15)
opt('w', 'wrap', false)
opt('o', 'sm', true)
opt('w', 'scl', 'yes')
opt('o', 'smd', false)
opt('o', 'ph', 10)
opt('o', 'sb', true)
opt('o', 'spr', true)

opt('b', 'ts', 4)
opt('b', 'sw', 4)
opt('b', 'et', true)
opt('b', 'si', true)

vim.opt.isk:append('-')
vim.opt.shm:append('atc')
opt('o', 'icm', 'split')

opt('b', 'spl', 'en_gb')
