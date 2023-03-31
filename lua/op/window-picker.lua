local win_picker_status_ok, window_picker = pcall(require, "window-picker")
if not win_picker_status_ok then
  return
end

-- setup window_picker
window_picker.setup({
  autoselect_one = true,
  include_current = false,
  filter_rules = {
    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = { 'neo-tree', "neo-tree-popup", "notify" },
      -- if the buffer type is one of following, the window will be ignored
      buftype = { 'terminal', "quickfix" },
    },
  },
    -- the foreground (text) color of the picker
    fg_color = '#1e2024',

    -- if you have include_current_win == true, then current_win_hl_color will
    -- be highlighted using this background color
    current_win_hl_color = '#e35e4f',

    -- all the windows except the curren window will be highlighted using this
    -- color
    other_win_hl_color = '#f75f5f',
})
