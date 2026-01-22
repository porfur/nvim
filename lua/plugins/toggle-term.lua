return {
  -- TODO See what options can be removed
  -- https://github.com/akinsho/toggleterm.nvim
  "akinsho/toggleterm.nvim",
  config = function(_, opts)
    require("toggleterm").setup(opts)
    local Terminal = require("toggleterm.terminal").Terminal

    local terminal_g = Terminal:new({
      display_name = '[g]eneric Terminal',
      direction = "float",
      hide_numbers = false,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      close_on_exit = true,
      float_opts = { border = "curved" },
    })

    vim.keymap.set({ "n", "t" }, "<C-g>", function()
      terminal_g:toggle()
    end, { desc = "Toggle Terminal [G]eneric" })

    local cursor_term = Terminal:new({
      cmd = "cursor-agent",
      display_name = 'C[v]rsor Agent',
      direction = "vertical",
      size = 100,
      hide_numbers = false,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      close_on_exit = true,
      shell = vim.o.shell,
      -- float_opts = { border = "curved" },
    })

    vim.keymap.set({ "n", "t" }, "<C-v>", function()
      cursor_term:toggle(80)
    end, { desc = "Toggle Cursor CLI terminal" })
  end,
}
