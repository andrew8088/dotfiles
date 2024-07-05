return {
  {
    'mhartington/formatter.nvim',
    config = function()
      require('formatter').setup {
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
          javascript = {
            require('formatter.filetypes.typescript').prettierd,
          },
          typescript = {
            require('formatter.filetypes.typescript').prettierd,
          },
          lua = {
            require('formatter.filetypes.lua').stylua,
          },
          ['*'] = {
            require('formatter.filetypes.any').remove_trailing_whitespace,
          },
        },
      }

      vim.api.nvim_create_augroup('__formatter__', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePost', {
        group = '__formatter__',
        command = ':FormatWrite',
      })
    end,
  },
}
