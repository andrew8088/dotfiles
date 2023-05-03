local M = {}

M.jump_to_test_file  = function()
    print(vim.api.nvim_buf_get_name(0))
end

return M
