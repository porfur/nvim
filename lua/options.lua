-- TODO: REMOVE UNUSED
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.backup = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.cmdheight = 1
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.conceallevel = 0
vim.opt.fileencoding = 'utf-8'
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.mouse = 'a'
vim.opt.showmode = true
vim.opt.showtabline = 1
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2   -- Number of spaces to use for each step of (auto)indent
vim.opt.tabstop = 2      -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 2  -- Number of spaces inserted/deleted when hitting <Tab>/<BS>
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.indentexpr = ''
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.foldmethod = 'indent'
vim.opt.foldenable = false
vim.opt.path:append("**") -- enable recursive search

-- if vim.g.neovide then
-- -- NOTE: Neovide specific options
-- end

vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  virtual_text = false,
}
