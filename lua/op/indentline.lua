local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
  return
end

indent_blankline.setup {
  debounce = 500,
  indent = { char = "▏", smart_indent_cap=true},
    -- enabled
      --   enabled
        -- enabled
  whitespace = { highlight = { "Whitespace", "NonText" } },
    exclude = {
      -- language = { "lua" } ,
      filetypes = {
        "help",
        "packer",
        "NvimTree",
      },
      buftypes = { "terminal", "nofile" },

    }



}


-- Old indent line settings
-- show_trailing_blankline_indent = false,
-- show_first_indent_level = true,
-- use_treesitter = true,
-- show_current_context = true,
-- buftype_exclude = { "terminal", "nofile" },
-- filetype_exclude = {
--   "help",
--   "packer",
--   "NvimTree",
-- indent_blankline.setup {
--   char = "▏",
--   show_trailing_blankline_indent = false,
--   show_first_indent_level = true,
--   use_treesitter = true,
--   show_current_context = true,
--   buftype_exclude = { "terminal", "nofile" },
--   filetype_exclude = {
--     "help",
--     "packer",
--     "NvimTree",
--   },
-- }
