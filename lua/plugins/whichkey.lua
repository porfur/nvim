return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config=function()
local whichkey = require('which-key')
whichkey.register({
    ["<leader>b"] = { name = "Buffer" },
    ["<leader>c"] = { name = "[C]ode (LSP)" },
    ["<leader>g"] = { name = "[G]it" },
    ["<leader>w"] = { name = "[W]orkspace" },
    ["<leader>s"] = { name = "[S]earch" },
})
  end
}

