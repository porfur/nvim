return {
  { -- https://github.com/xTacobaco/cursor-agent.nvim
  "xTacobaco/cursor-agent.nvim",
  config = function()
    vim.keymap.set("n", "<leader>ii", ":CursorAgent<CR>", { desc = "Cursor Agent: Toggle terminal" })
    vim.keymap.set("v", "<leader>ii", ":CursorAgentSelection<CR>", { desc = "Cursor Agent: Send selection" })
    vim.keymap.set("n", "<leader>ib", ":CursorAgentBuffer<CR>", { desc = "Cursor Agent: Send buffer" })
  end, }
}

