return {
     -- Set lualine as statusline
     'nvim-lualine/lualine.nvim',
     -- See `:help lualine.txt`
     opts = {
       options = {
         icons_enabled = true,
         theme = 'catppuccin-mocha',
         component_separators = '|',
         section_separators = '',
       },
     },
}
