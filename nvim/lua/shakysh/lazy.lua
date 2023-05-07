require("lazy").setup({
    { "folke/tokyonight.nvim", },
    { "catppuccin/nvim", name = "catppuccin" },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            vim.cmd.TSUpdate()
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    { 'theprimeagen/harpoon' },
    { 'mbbill/undotree' },
    { "lukas-reineke/indent-blankline.nvim" },
    { "tpope/vim-fugitive" },
    { "tpope/vim-rhubarb" },
    { "tpope/vim-repeat" },
    { "tpope/vim-sleuth" },
    { "lewis6991/gitsigns.nvim" },
    { "tpope/vim-eunuch" },
    -- { "goolord/alpha-nvim" },
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    { "numToStr/Comment.nvim" },
    { "RRethy/vim-illuminate" },
    { "folke/which-key.nvim" },
    { "ggandor/leap.nvim" },
    { "jose-elias-alvarez/typescript.nvim" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "folke/trouble.nvim" },
    { "sigmasd/deno-nvim" },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- context
            { "SmiteshP/nvim-navic" },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }
})
