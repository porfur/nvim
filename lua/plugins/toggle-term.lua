return {
  -- TODO See what options can be removed
  -- https://github.com/akinsho/toggleterm.nvim
  "akinsho/toggleterm.nvim",
  config = function(_, opts)
    require("toggleterm").setup(opts)
    local Terminal = require("toggleterm.terminal").Terminal

    local terminal_g = Terminal:new({
      display_name = '[C-g] Terminal',
      direction = "float",
      hide_numbers = false,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      close_on_exit = true,
      float_opts = { border = "curved" },
    })

    vim.keymap.set({ "n", "t" }, "<C-g><C-g>", function()
      terminal_g:toggle()
    end, { desc = "Toggle Terminal [G]eneric" })

    local terminal_t = Terminal:new({
      display_name = '[C-t] Terminal',
      direction = "float",
      hide_numbers = false,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      close_on_exit = true,
      float_opts = { border = "curved" },
    })

    vim.keymap.set({ "n", "t" }, "<C-g><C-t>", function()
      terminal_t:toggle()
    end, { desc = "Toggle [T]erminal Generic" })

    local cursor_term = Terminal:new({
      cmd = "cursor-agent",
      display_name = '[C-i] Cursor Agent',
      direction = "float",
      size = 100,
      hide_numbers = false,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = { border = "curved" },
    })

    vim.keymap.set({ "n", "t" }, "||", function()
     cursor_term:toggle(80)
    end, { desc = "Toggle Cursor CLI terminal" })

    local opencode_term = Terminal:new({
      cmd = "opencode",
      display_name = '[\\\\] OpenCode',
      direction = "float",
      size = 100,
      hide_numbers = false,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = { border = "curved" },
    })

    vim.keymap.set({ "n", "t" }, "\\\\", function()
      opencode_term:toggle(80)
    end, { desc = "Toggle OpenCode CLI terminal" })
  end,
}
