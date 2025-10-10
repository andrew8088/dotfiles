return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        -- NOTE: this is here because mason-lspconfig must install servers prior to running nvim-lspconfig
        lazy = false,
        dependencies = {
          {
            -- NOTE: this is here because mason.setup must run prior to running nvim-lspconfig
            -- see mason.lua for more settings.
            "williamboman/mason.nvim",
            lazy = false,
          },
        },
      },
      {
        "hrsh7th/nvim-cmp",
        lazy = false,
        -- NOTE: this is here because we get the default client capabilities from cmp_nvim_lsp
        -- see cmp.lua for more settings.
      },
      {
        "artemave/workspace-diagnostics.nvim",
        enabled = false,
      },
      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      {
        "j-hui/fidget.nvim",
        enabled = true, -- TODO: figure out how this status shows without fidget
        opts = {},
      },
    },
    config = function()
      local servers = {
        ts_ls = {
          cmd = { "pnpm", "exec", "typescript-language-server", "--stdio" },
          init_options = {
            preferences = {
              disableSuggestions = false,
              quotePreference = "auto",
              includeCompletionsForModuleExports = true,
              includeCompletionsForImportStatements = true,
              includeCompletionsWithSnippetText = true,
              includeAutomaticOptionalChainCompletions = true,
            },
          },
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
              suggest = {
                includeCompletionsForModuleExports = true,
              },
              preferences = {
                includePackageJsonAutoImports = "auto",
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              format = {
                enable = true,
              },
            },
          },
        },
      }

      -- TODO: extend config with inspiration from
      -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua

      require("utils.diagnostics").setup_diagnostics()

      -- LSP servers and clients are able to communicate to each other what features they support.
      -- By default, Neovim doesn't support everything that is in the LSP Specification.
      -- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      -- So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local client_capabilities = vim.lsp.protocol.make_client_capabilities()
      -- The nvim-cmp almost supports LSP's capabilities so you should advertise it to LSP servers..
      local completion_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local capabilities = vim.tbl_deep_extend("force", client_capabilities, completion_capabilities)

      -- Define on_attach callback at higher scope for better stability
      local function on_attach_callback(client, bufnr)
        local nmap = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        -- Use explicit space instead of <leader>
        nmap(' rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap(' ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap(' D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('L', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Format on save
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end

      for name, opts in pairs(servers) do
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          on_attach = on_attach_callback,
        }, opts or {})

        vim.lsp.config(name, server_opts)
        vim.lsp.enable(name)
      end
    end,
  },
}
