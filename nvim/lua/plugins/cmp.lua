-- yanked from https://github.com/fredrikaverpil/dotfiles/blob/main/nvim-lazyvim/lua/plugins/cmp.lua
return {
	-- nvim-cmp configuration so to not preselect completion and require tab to select
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-emoji" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{
				"hrsh7th/cmp-nvim-lsp",
				dependencies = {
					{
						"L3MON4D3/LuaSnip",
						dependencies = {
							"saadparwaiz1/cmp_luasnip",
							"rafamadriz/friendly-snippets",
						},
					},
				},
			},
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			-- local has_words_before = function()
			-- 	unpack = unpack or table.unpack
			-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			-- 	return col ~= 0 and
			-- 		vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") ==
			-- 	nil
			-- end

			local luasnip = require("luasnip")
			local cmp = require("cmp")

			-- local mapping = {
			-- 	["<CR>"] = vim.NIL,
			--
			-- 	["<Tab>"] = cmp.mapping(function(fallback)
			-- 		if cmp.visible() then
			-- 			cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
			-- 			-- NOTE: to accept Copilot suggestion, use the keymap for "accept" (<M-l>)
			-- 			-- elseif require("copilot.suggestion").is_visible() then
			-- 			--  require("copilot.suggestion").accept()
			-- 		elseif luasnip.expand_or_locally_jumpable() then
			-- 			luasnip.expand_or_jump()
			-- 		elseif has_words_before() then
			-- 			cmp.complete()
			-- 		else
			-- 			fallback()
			-- 		end
			-- 	end, { "i", "s" }),
			--
			-- 	["<S-Tab>"] = cmp.mapping(function(fallback)
			-- 		if cmp.visible() then
			-- 			cmp.select_prev_item()
			-- 		elseif luasnip.jumpable(-1) then
			-- 			luasnip.jump(-1)
			-- 		else
			-- 			fallback()
			-- 		end
			-- 	end, { "i", "s" }),
			-- }
			--
			-- if opts.mapping == nil then
			-- 	opts.mapping = mapping
			-- else
			-- 	opts.mapping = vim.tbl_extend("force", opts.mapping, mapping)
			--
			-- end
			-- opts.preselect = cmp.PreselectMode.None
			--
			-- local sources = {
			-- 	{ name = "emoji" },
			-- }
			-- if opts.sources == nil then
			-- 	opts.sources = sources
			-- else
			-- 	opts.sources = cmp.config.sources(vim.list_extend(opts.sources, sources))
			-- end

			-- debug
			-- vim.api.nvim_echo({ { "opts.sources: " .. vim.inspect(opts.sources), "Normal" } }, true, {})

			-- require('luasnip.loaders.from_vscode').lazy_load()
			luasnip.config.setup({})

			cmp.setup({
			  snippet = {
			    expand = function(args)
			      luasnip.lsp_expand(args.body)
			    end,
			  },
			  mapping = cmp.mapping.preset.insert {
			    ['<C-n>'] = cmp.mapping.select_next_item(),
			    ['<C-p>'] = cmp.mapping.select_prev_item(),
			    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
			    ['<C-f>'] = cmp.mapping.scroll_docs(4),
			    ['<C-Space>'] = cmp.mapping.complete {},
			    ['<CR>'] = cmp.mapping.confirm {
			      behavior = cmp.ConfirmBehavior.Replace,
			      select = true,
			    },
			 --    ['<Tab>'] = cmp.mapping(function(fallback)
			 --      if cmp.visible() then
				-- cmp.select_next_item()
			 --      elseif luasnip.expand_or_locally_jumpable() then
				-- luasnip.expand_or_jump()
			 --      else
				-- fallback()
			 --      end
			 --    end, { 'i', 's' }),
			 --    ['<S-Tab>'] = cmp.mapping(function(fallback)
			 --      if cmp.visible() then
				-- cmp.select_prev_item()
			 --      elseif luasnip.locally_jumpable(-1) then
				-- luasnip.jump(-1)
			 --      else
				-- fallback()
			 --      end
			 --    end, { 'i', 's' }),
			  },
			  sources = {
			    { name = 'nvim_lsp' },
			    { name = 'luasnip' },
			  },
			})
		end,
	},

	{
		"hrsh7th/cmp-cmdline",
		config = function()
			local cmp = require("cmp")
			---@diagnostic disable-next-line: missing-fields
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<C-j>"] = {
						c = function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							else
								fallback()
							end
						end,
					},
					["<C-k>"] = {
						c = function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							else
								fallback()
							end
						end,
					},
				}),
				sources = cmp.config.sources({
					{ name = "path" },
					}, {
						{
							name = "cmdline",
							option = {
								ignore_cmds = { "Man", "!" },
							},
						},
				}),
			})
		end,
	},
}
