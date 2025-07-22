return {
  -- Neo-tree is a Neovim plugin to browse the file system
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    {
      -- https://github.com/s1n7ax/nvim-window-picker
      's1n7ax/nvim-window-picker',
      name = 'window-picker',
      event = 'VeryLazy',
      version = '2.*',
      opts = { hint = 'floating-big-letter' },
    }
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree right reveal<CR>', desc = 'neoTree right reveal', silent = true },
    { '<leader>e', ':Neotree float toggle<CR>', desc = 'n[e]oTree right toggle', silent = true },
    { '<leader>E', ':Neotree left toggle<CR>', desc = 'n[E]oTree toggle', silent = true },
  },
  opts = {
    default_component_configs = {
        icon = {
          enabled = false
        }
      },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
    event_handlers = {
      {
        event = 'neo_tree_buffer_enter',
        handler = function()
          vim.cmd [[
          setlocal relativenumber
          ]]
        end,
      },
    },
  },
}
