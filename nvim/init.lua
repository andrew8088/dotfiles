require('config.options');
require('config.keymaps');
require('config.autocmds');
require('config.lazy');

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.

-- local util = require 'lspconfig.util'
-- local servers = {
--   denols = {
--     root_dir = function(fname)
--       return util.root_pattern('deno.json', 'deno.jsonc')(fname)
--     end,
--     single_file_support = false,
--   },
-- }

-- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'
--
-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }
--
-- mason_lspconfig.setup_handlers({
--   function(server_name)
--     local config = {
--       capabilities = capabilities,
--       on_attach = on_attach,
--     }
--
--     local server_config = servers[server_name]
--
--     for k, v in pairs(server_config) do
--       config[k] = v
--     end
--
--     require('lspconfig')[server_name].setup(config);
--   end,
-- })

-- vim: ts=2 sts=2 sw=2 et
