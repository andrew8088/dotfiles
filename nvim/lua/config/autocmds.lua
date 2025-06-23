vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
	pattern = '*',
})

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		local diagnostics = vim.diagnostic.get(0, {
			severity = vim.diagnostic.severity.ERROR,
		})
		local items = vim.diagnostic.toqflist(diagnostics)

		-- Always update the location list
		vim.fn.setloclist(0, {}, ' ', {
			title = 'Errors',
			items = items,
		})

		-- Open or close the location list based on presence of errors
		if #items > 0 then
			vim.cmd('lopen')
		else
			vim.cmd('lclose')
		end
	end,
})
