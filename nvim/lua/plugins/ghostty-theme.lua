return {
	{
	  'landerson02/ghostty-theme-sync.nvim',
		--- @type GhosttySyncConfig
		opts = {
			ghostty_config_path = "~/.config/ghostty/config",
			-- If you want to keep the nvim colorscheme change (like the ghostty change),
			-- set this to true and point the config path to your config file that contains
			-- a line of the form: `vim.cmd.colorscheme('<colorscheme>')`
			-- The plugin will change this line to the selected theme
			persist_nvim_theme = true,
			nvim_config_path = "~/.config/nvim/lua/config/lazy.lua",
		},
	}
}
