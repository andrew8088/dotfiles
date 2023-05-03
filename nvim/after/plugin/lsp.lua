local lsp = require('lsp-zero')
local null_ls = require("null-ls")
local navic = require("nvim-navic")
local lspconfig = require("lspconfig");

-- require("lspconfig").setup({
--     on_attach = function(client, bufnr)
--         navic.attach(client, bufnr)
--     end
-- })

lsp.preset('recommended')

lsp.ensure_installed({
	'tsserver',
	'eslint',
	'rust_analyzer'
})

lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.set_preferences({
	suggest_lsp_servers = false,
})

-- lsp.format_on_save({
-- 	servers = {
-- 		["eslint"] = { "javascript" },
-- 		["lua_ls"] = { "lua" },
-- 		["tsserver"] = { "typescript" },
-- 		["rust_analyzer"] = { "rust" },
-- 	},
-- })

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	-- configured by Trouble
	-- vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	-- vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<leader>lj", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "<leader>lk", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- from https://github.com/VonHeikemen/lsp-zero.nvim/issues/17
local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local null_opts = lsp.build_options('null-ls', {
	on_attach = function(client, bufnr)
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			group = group,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr, async = false })
			end,
			desc = "[lsp] format on save",
		})
	end
})
--
-- lspconfig.denols.setup {
--   on_attach = lsp.on_attach,
--   root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
-- }
--
-- lspconfig.tsserver.setup {
--   on_attach = lsp.on_attach,
--   root_dir = lspconfig.util.root_pattern("package.json"),
--   single_file_support = false
-- }

null_ls.setup({
	on_attach = null_opts.on_attach,
	sources = {
		-- null_ls.builtins.formatting.prettierd,
		null_ls.builtins.diagnostics.eslint_d,
		require("typescript.extensions.null-ls.code-actions"),
	}
})

lsp.setup()

vim.diagnostic.config({
	virtual_text = true
})
