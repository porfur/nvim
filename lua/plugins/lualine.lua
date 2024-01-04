-- https://github.com/nvim-lualine/lualine.nvim
-- Enabled by default in kickstart
-- This overrides the kickstart defaults

-- Function to hide when window is too small
local hide = function(section, width)
  width = width or 150
  local condition = function()
    return vim.fn.winwidth(0) > width
  end
  return { section, cond = condition }
end

  return {
    "nvim-lualine/lualine.nvim"
    ,
    opts={
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'alpha', 'dashboard', 'packer', 'NVimTree' },
          disabled_buftypes = { 'quickfix', 'prompt' },
          ignore_focus = {},
          always_divide_middle = false,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { { 'filename', path = 1 } },
          lualine_c = { hide 'diff', hide 'diagnostics' },
          lualine_x = { hide('branch', 100), hide 'encoding', hide 'fileformat', hide 'filetype' },
          lualine_y = { hide 'progress' },
          lualine_z = { hide 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = { 'nvim-tree', 'neo-tree' },
      }
  }
