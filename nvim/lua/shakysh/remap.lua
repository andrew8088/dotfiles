vim.g.mapleader = " "
vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set("n", "<C-h>", vim.cmd.bprevious)
vim.keymap.set("n", "<C-l>", vim.cmd.bnext)
vim.keymap.set("n", ",", vim.cmd.nohlsearch)

