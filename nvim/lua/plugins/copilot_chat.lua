return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = true,
    branch = "canary", -- while in development
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false, -- Enable debugging
    },
  },
}
