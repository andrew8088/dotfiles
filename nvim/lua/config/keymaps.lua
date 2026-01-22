-- print("keymaps: start")
vim.keymap.set('n', ';', ':', { noremap = true })
-- Remove this line - it blocks leader key mappings
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<C-l>', ":bnext<CR>", { silent = true })
vim.keymap.set('n', '<C-h>', ":bprevious<CR>", { silent = true })

vim.keymap.set('n', '<C-t>', ":!pnpm exec mocha %<CR>")

vim.keymap.set("n", "/", "/\\v", { noremap = true })
vim.keymap.set("n", "?", "?\\v", { noremap = true })

vim.cmd([[
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Q! q!
cnoreabbrev Today ObsidianToday
nnoremap <leader>m :!yarn run mocha %<CR>
]])

local errors = vim.diagnostic.get(0, {
	severity = vim.diagnostic.severity.ERROR,
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', '<leader>q', function()
	vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.ERROR })
end, { desc = 'Open diagnostics list (errors only)' })

-- print("keymaps: done")
