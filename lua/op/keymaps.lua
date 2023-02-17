-- Shorten function name
local key = vim.keymap

-- Silent keymap option & Desc
local opts = function(desc) return{ silent = false,desc=desc or "NEED DESC"}end

--Remap space as leader key
key.set("", "<Space>", "<Nop>", opts('Space'))
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


--
key.set("i", "<C-s>", "<Plug>luasnip-expand-snippet", opts('Window Navigate Left'))
-- Better window navigation
key.set("n", "<C-h>", "<C-w>h", opts('Window Navigate Left'))
key.set("n", "<C-j>", "<C-w>j", opts('Window Navigate Down'))
key.set("n", "<C-k>", "<C-w>k", opts('Window Navigate Up'))
key.set("n", "<C-l>", "<C-w>l", opts('Window Navigate Right'))
key.set("n", "<C-c>", "<C-w>c", opts('Close Window'))
--Tmux Navigator should match window navigation
key.set('n', '<C-h>','<cmd><C-U>TmuxNavigateLeft<cr>', opts( 'Tmux Navigate Left' ))
key.set('n', '<C-j>','<cmd><C-U>TmuxNavigateDown<cr>', opts( 'Tmux Navigate Down' ))
key.set('n', '<C-k>','<cmd><C-U>TmuxNavigateUp<cr>', opts( 'Tmux Navigate Up' ))
key.set('n', '<C-l>','<cmd><C-U>TmuxNavigateRight<cr>', opts( 'Tmux Navigate Right' ))
-- Resize with Alt-hjkl
key.set("n", "˚", "<cmd>resize -2<CR>", opts('Window Horizontal Shrink'))
key.set("n", "∆", "<cmd>resize +2<CR>", opts('Window Horizontal Grow'))
key.set("n", "˙", "<cmd>vertical resize -2<CR>", opts('Window Vertical Shrink'))
key.set("n", "¬", "<cmd>vertical resize +2<CR>", opts('Window Vertical Grow'))
key.set("n", "≠", "<C-w>=", opts('Equalize Windows'))
--Leader window commands
key.set("n", "<leader>wh", "<C-w>h", opts('Window Navigate Left'))
key.set("n", "<leader>wj", "<C-w>j", opts('Window Navigate Down'))
key.set("n", "<leader>wk", "<C-w>k", opts('Window Navigate Up'))
key.set("n", "<leader>wl", "<C-w>l", opts('Window Navigate Right'))
key.set("n", "<leader>wc", "<C-w>c", opts('Close Window'))
key.set("n", "<leader>wr", "<C-w>r", opts('Swap Windows'))
key.set("n", "<leader>wo", "<C-w>o", opts('Only Window'))
key.set("n", "<leader>w=", "<C-w>=", opts('Equalize Windows'))
key.set("n", "<leader>wv", "<C-w>v", opts('Vertical Split'))
key.set("n", "<leader>ws", "<C-w>s", opts('Horizontal Split'))

-- Navigate buffers
key.set("n", "<C-n>", "<cmd>bnext<CR>", opts('Buffer Next'))
key.set("n", "<C-p>", "<cmd>bprevious<CR>", opts('Buffer Previous'))
key.set("n", "<leader>bn", "<cmd>bnext<CR>", opts('Buffer Next'))
key.set("n", "<leader>bp", "<cmd>bprevious<CR>", opts('Buffer Previous'))

--Save buffers
key.set({ 'n', 'v' }, '<leader>bs', '<cmd>write<CR>', opts('Write Buffer'))
key.set({ 'n', 'v' }, '<leader>bS', '<cmd>wall<CR>', opts('Write all Buffers'))
key.set({ 'n', 'v' }, '<leader>bw', '<cmd>write<CR>', opts('Write Buffer'))
key.set({ 'n', 'v' }, '<leader>bW', '<cmd>wall<CR>', opts('Write all Buffers'))
key.set({ 'n', 'v', },  '<C-s>', '<cmd>write<CR>', opts('Write Buffer'))
key.set({ 'n', 'v', }, '<C-S>', '<cmd>wall<CR>', opts('Write all Buffers'))

-- Close buffers
-- switch to prev buffer then delete prev buffer [ bdelete# ]
-- That way splits dont close 
key.set("n", "<leader>bD", "<cmd>bprevious<bar>bdelete!#<CR>", opts('Delete Buffer (Discard Changes)'))
key.set("n", "<leader>bd", "<cmd>bprevious<bar>bdelete#<CR>", opts('Delete Buffer'))
key.set("n", "<leader>bc", "<cmd>write<bar><bprevious<bar>bdelete#<CR>", opts('Write & Delete Buffer'))
key.set("n", "<leader>bC", "<cmd>wall<bar> %bdelete<CR>", opts('Write & Delete Buffers'))
key.set("n", "<leader>bqq", "<cmd>q!<CR>", opts('Quit Buffer'))
key.set("n", "<leader>bQQ", "<cmd>qa!<CR>", opts('Quit All Buffers'))

-- Clear highlights
key.set("n", "<leader>h", "<cmd>nohlsearch<cr>", opts('clear search highlight'))

-- better paste
key.set("v", "p", '"_dp', opts())

-- insert --
-- press jk fast to enter
key.set("i", "kj", "<esc>", opts())

-- visual --
-- stay in indent mode
key.set("v", "<", "<gv", opts())
key.set("v", ">", ">gv", opts())

-- Plugins --

-- NvimTree
key.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts('Toggle NvimTree'))
-- Git
key.set("n", "<leader>gg", "<cmd>LazyGit<CR>", opts('Lazy [G]it'))
key.set("n", "<leader>gb", "<cmd>GitBlameToggle<CR>", opts('Lazy [G]it'))

-- Comment
-- key.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts())
-- key.set("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts())

-- DAP
key.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts())
key.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts())
key.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts())
key.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts())
key.set("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts())
key.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts())
key.set("n", "<leader>dle", "<cmd>lua require'dap'.run_last()<cr>", opts())
key.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts())
key.set("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts())

-- Lsp
key.set("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts())
