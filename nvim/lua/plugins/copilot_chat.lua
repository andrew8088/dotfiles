return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = true,
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false, -- Enable debugging
    },
  },
}
