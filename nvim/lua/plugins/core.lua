return {
  -- git wrapper
  'tpope/vim-fugitive',
  -- github wrapper
  'tpope/vim-rhubarb',
  -- unix/bash tooling
  'tpope/vim-eunuch',
  -- Detect tabstop and shiftwidth automatically
  -- 'tpope/vim-sleuth',
  -- better tabstop and shiftwidth
  {
    'FotiadisM/tabset.nvim',
    config = function()
      require('tabset').setup {
        defaults = {
          tabwidth = 2,
          expandtab = true,
        },
      }
    end,
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  -- a collection of lua functions
  'nvim-lua/plenary.nvim',
}
