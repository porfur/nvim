--[[ OPTIONS START ]]
-- TODO REMOVE UNUSED
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.mouse = "a"
-- vim.opt.showmode = false
vim.opt.showtabline = 1
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.fillchars.eob=" "
vim.opt.linebreak = true
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.guifont = "Iosevka:h28"

--[[ OPTIONS END ]]


--[[ AUTOCOMMANDS START ]]
--TODO figure out when these are usefull
local autocmd = vim.api.nvim_create_autocmd
autocmd({ "FileType" },{
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
    callback = function()
      vim.cmd [[ nnoremap <silent> <buffer> q :close<CR> set nobuflisted
    ]]
    end,
  })

autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd "quit"
  end,
})

autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})

autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 5000 then
      vim.cmd "IlluminatePauseBuf"
    end
  end,
})
--[[ AUTOCOMMANDS END ]]

--[[ KEYMAPS START ]]

-- MODES --
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--   all = "",

-- KEYMAP LOCALS --
local key = vim.keymap.set
local opts = function(desc)
  return { silent = false, desc = desc or '**No Description**' }
end

-- BINDINGS --
-- Disable Single Space
key('', '<Space>', '<Nop>', opts 'Space')

-- Center cursor when moving pages
key("n", "<C-d>", "<C-d>zz")
key("n", "<C-u>", "<C-u>zz")
key("n", "<C-f>", "<C-f>zz")
key("n", "<C-b>", "<C-b>zz")

-- Better window navigation
key('n', '<C-h>', '<C-w>h', opts 'Window Navigate Left')
key('n', '<C-j>', '<C-w>j', opts 'Window Navigate Down')
key('n', '<C-k>', '<C-w>k', opts 'Window Navigate Up')
key('n', '<C-l>', '<C-w>l', opts 'Window Navigate Right')

-- Resize with Alt-hjkl
key('n', '˚', ':resize -2<CR>', opts 'Window Horizontal Shrink')
key('n', '∆', ':resize +2<CR>', opts 'Window Horizontal Grow')
key('n', '˙', ':vertical resize -2<CR>', opts 'Window Vertical Shrink')
key('n', '¬', ':vertical resize +2<CR>', opts 'Window Vertical Grow')
key('n', '≠', '<C-w>=', opts 'Equalize Windows')

--Tabs
key('n', '<leader>tn', ':tabnew<CR>', opts 'Tab New')
key('n', '<leader>tc', ':tabclose<CR>', opts 'Tab Close')
key('n', '<leader>to', ':tabonly<CR>', opts 'Tab Only')

-- Navigate buffers
key('n', '<C-n>', ':bnext<CR>', opts 'Buffer Next')
key('n', '<C-p>', ':bprevious<CR>', opts 'Buffer Previous')
key('n', '<C-6>', '<C-^>', opts 'Alternate Buffer')
key('n', '<leader>bn', ':bnext<CR>', opts 'Buffer Next')
key('n', '<leader>bp', ':bprevious<CR>', opts 'Buffer Previous')
key('n', '<leader>ba', '<C-^>', oet nobuflistedts 'Alternate Buffer')

--Save buffers
key({ 'n', 'v' }, '<leader>bs', ':write<CR>', opts 'Write Buffer')
key({ 'n', 'v' }, 'ZS', ':write<CR>', opts 'Write Buffer')
key({ 'n', 'v' }, '<leader>bS', ':wall<CR>', opts 'Write all Buffers')
key({ 'n', 'v' }, '<leader>bw', ':write<CR>', opts 'Write Buffer')
key({ 'n', 'v' }, '<leader>bW', ':wall<CR>', opts 'Write all Buffers')
key({ 'n', 'v' }, '<C-s>', ':write<CR>', opts 'Write Buffer')
key({ 'n', 'v' }, '<C-S>', ':wall<CR>', opts 'Write all Buffers')

-- Close buffers
-- TODO SIMPLIFY THIS USING THE Z command
-- switch to prev buffer then delete prev buffer [ bdelete# ]
-- That way splits dont close
key('n', '<leader>bd', ':bprevious<bar>bdelete#!<CR>', opts 'Delete Buffer (Discard Changes)')
key('n', '<leader>bD', ':bprevious<bar> %bdelete!<CR>', opts  'Delete All Buffer (Discard Changes)')
key('n', '<leader>bc', ':write<bar>bprevious<bar>bdelete#<CR>', opts 'Write & Delete Buffer')
key('n', '<leader>bC', ':wall<bar> %bdelete<CR>', opts 'Write & Delete Buffers')
key('n', '<leader>bqq<CR>', ':qa!<CR>', opts  'Quit All Buffers')

-- Clear highlights
key('n', '<leader>x', ':nohlsearch<cr>', opts 'clear search highlight')

-- Paste in visual mode doesn't polute the clipboard with the old selection
key('v', 'p', '"_dp', opts())

-- press jk fast to esc
key('i', 'kj', '<esc>', opts())

-- visual --
-- stay in indent mode
key('v', '<', '<gv', opts())
key('v', '>', '>gv', opts())

-- Netrw
key('n', '<leader>o-', vim.cmd.Ex, opts 'Open Netrw')

-- Move line in visual mode
key('v', 'J', ":m '>+1<CR>gv=gv")
key('v', 'K', ":m '<-2<CR>gv=gv")

--Insert New Line in normal mode
key('n', '[o', 'moO<ESC>`o', opts 'Empty Line above')
key('n', ']o', 'moo<ESC>`o', opts 'Empty Line below')

-- Split Line
key('n', '<Enter>', 'i<CR><Esc>', opts 'Split line (Opposite of J)')

-- Sessions
key('n', '<leader>qs', ':mksession!<CR>', opts 'Make session')
key('n', '<leader>ql', ':source Session.vim<CR>', opts 'Make load')

--[[ KEYMAPS END ]]
-- [[Lazy setup]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
   { 'tpope/vim-fugitive' },
   { 'tpope/vim-rhubarb' },
   { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
  { import = 'plugins' },
  { import = 'plugins.lsp' },
})
