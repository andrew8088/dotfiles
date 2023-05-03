local wk = require("which-key")

vim.o.timeout = true
vim.o.timeoutlen = 300
wk.setup({
-- your configuration comes here
-- or leave it empty to use the default settings
-- refer to the configuration section below
})

wk.register({
ln = "prev buffer",


}, { prefix = "<leader>" });

-- vim.keymap.set("n", ";", ":", { noremap = true })
-- vim.keymap.set("n", "<C-h>", vim.cmd.bprevious)
-- vim.keymap.set("n", "<C-l>", vim.cmd.bnext)
-- vim.keymap.set("n", ",", vim.cmd.nohlsearch)
