local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end
local hide = function(section, width)
  width = width or 60
  local condition = function()
    return vim.fn.winwidth(0) > width
  end
  return { section, cond = condition }
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'alpha', 'dashboard', 'packer', 'NVimTree' },
    disabled_buftypes = { 'quickfix', 'prompt' },
    ignore_focus = {},
    always_divide_middle = true,
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
    lualine_c = { hide ( 'branch',100 ), hide 'diff', hide 'diagnostics' },
    lualine_x = { hide 'encoding', hide 'fileformat', hide 'filetype' },
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
