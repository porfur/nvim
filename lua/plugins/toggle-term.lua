return {
  -- TODO See what options can be removed
  -- https://github.com/akinsho/toggleterm.nvim
  'akinsho/toggleterm.nvim',
  config = function(_, opts)
    require('toggleterm').setup(opts)
    local Terminal = require('toggleterm.terminal').Terminal

    local function create_terminals(keys)
      local terminals = {}

      for _, key in ipairs(keys) do
        terminals[key] = Terminal:new {
          display_name = '[C-' .. key .. ']',
          direction = 'float',
          size = 100,
          hide_numbers = false,
          shade_terminals = true,
          shading_factor = 2,
          start_in_insert = true,
          insert_mappings = true,
          close_on_exit = true,
          shell = vim.o.shell,
          float_opts = {
            border = 'curved',
          },
        }

        vim.keymap.set({ 'n', 't' }, '<C-' .. key .. '>', function()
          terminals[key]:toggle(80)
        end, {
          desc = 'Toggle terminal ' .. key,
        })
      end

      return terminals
    end

    local cursor_terms = create_terminals { 't', 'g' }

    local claude_term = Terminal:new {
      cmd = 'claude',
      display_name = '[\\\\] Claude',
      direction = 'float',
      size = 100,
      hide_numbers = false,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = { border = 'curved' },
    }

    vim.keymap.set({ 'n', 't' }, '\\\\', function()
      claude_term:toggle(80)
    end, { desc = 'Toggle Claude CLI terminal' })

    local opencode_term = Terminal:new {
      cmd = 'opencode',
      display_name = '||',
      direction = 'float',
      size = 100,
      hide_numbers = false,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = { border = 'curved' },
    }

    vim.keymap.set({ 'n', 't' }, '||', function()
      opencode_term:toggle(80)
    end, { desc = 'Toggle OpenCode CLI terminal' })
  end,
}
