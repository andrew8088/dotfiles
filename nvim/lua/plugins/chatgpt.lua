return {
  {
    "jackMort/ChatGPT.nvim",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    -- event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        actions_paths = { vim.fn.stdpath('config') .. "/chatgpt-actions.json" },
        openai_params = {
          model = "gpt-4",
          max_tokens = 4000,
        },
        openai_edit_params = {
          model = "gpt-4",
          temperature = 0,
          top_p = 1,
          n = 1,
        },
      })
    end,
  },
}
