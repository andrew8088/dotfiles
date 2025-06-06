-- print('options: start')
M = {}

-- Set the leader key - must be the first thing
-- nvim loads, for correct plugin config
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- vim.g.vim_markdown_folding_disabled = 1
vim.o.foldmethod = 'marker'
vim.o.foldlevel = 0

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.filetype.add({
  pattern = {
    ['Jenkinsfile%.%w+'] = 'groovy',
  },
})

-- print('options: done')
return M
