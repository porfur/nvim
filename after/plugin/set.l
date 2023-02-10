vim.opt.termguicolors = true
-- Set theme to dracula
-- vim.cmd[[colorscheme dracula]]

-- Set lualine theme to match theme
-- if (vim.g.colors_name == "dracula")
-- then require('lualine').setup{options={theme='dracula-nvim'}}
-- end
-- Editor Layout settings
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.guifont = "Iosevka:h18"
vim.opt.autowrite= true

-- Netrw Layout Settings
vim.g.netrw_liststyle = 3
vim.g.netrw_bufsettings = 'rnu' -- relativenumber
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 20
vim.g.netrw_use_errorwindow = 0
vim.g.netrw_banner = 1
vim.g.netrw_keepdir = 0
