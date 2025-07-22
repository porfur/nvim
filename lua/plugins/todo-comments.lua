return {
  -- https://github.com/folke/todo-comments.nvim
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim',  'nvim-telescope/telescope.nvim',
 },
  -- opts = { signs = false },
  config = function()
    local todo_comments = require("todo-comments")
    todo_comments.setup({ signs = false })
    local map = vim.keymap.set
    map('n', '<leader>snn', ':TodoTelescope keywords=NOTE<CR>', { desc = '[s]earch [n]otes' })
    map('n', '<leader>snt', ':TodoTelescope keywords=TODO<CR>', { desc = '[s]earch [t]o do' })
    map('n', '<leader>snh', ':TodoTelescope keywords=HACK<CR>', { desc = '[s]earch [h]ack' })
    map('n', '<leader>snw', ':TodoTelescope keywords=WARN<CR>', { desc = '[s]earch [w]arn' })
    map('n', '<leader>snp', ':TodoTelescope keywords=PERF<CR>', { desc = '[s]earch [p]erf' })
    map('n', '<leader>snT', ':TodoTelescope keywords=TEST<CR>', { desc = '[s]earch [T]est' })
  end,
}
