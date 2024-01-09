--[[ FUNCTIONS START ]]
local key = key
local opts = function(desc)
  return { silent = false, desc = desc or '**No Description**' }
end

--[[ FUNCTIONS END]]
--Remap space as leader key
key('', '<Space>', '<Nop>', opts 'Space')

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--Primagen
-- key("n", "J", "mzJ`z")
key("n", "<C-d>", "<C-d>zz")
key("n", "<C-u>", "<C-u>zz")
-- key("n", "n", "nzzzv")
-- key("n", "N", "Nzzzv")
--
-- Better window navigation
key('n', '<C-h>', '<C-w>h', opts 'Window Navigate Left')
key('n', '<C-j>', '<C-w>j', opts 'Window Navigate Down')
key('n', '<C-k>', '<C-w>k', opts 'Window Navigate Up')
key('n', '<C-l>', '<C-w>l', opts 'Window Navigate Right')
key('n', '<C-c>', '<C-w>c', opts 'Close Window')
-- Resize with Alt-hjkl
key('n', '˚', '<cmd>resize -2<CR>', opts 'Window Horizontal Shrink')
key('n', '∆', '<cmd>resize +2<CR>', opts 'Window Horizontal Grow')
key('n', '˙', '<cmd>vertical resize -2<CR>', opts 'Window Vertical Shrink')
key('n', '¬', '<cmd>vertical resize +2<CR>', opts 'Window Vertical Grow')
key('n', '≠', '<C-w>=', opts 'Equalize Windows')
--Leader window commands
key('n', '<leader>wh', '<C-w>h', opts 'Window Navigate Left')
key('n', '<leader>wj', '<C-w>j', opts 'Window Navigate Down')
key('n', '<leader>wk', '<C-w>k', opts 'Window Navigate Up')
key('n', '<leader>wl', '<C-w>l', opts 'Window Navigate Right')
key('n', '<leader>wc', '<C-w>c', opts 'Close Window')
key('n', '<leader>wr', '<C-w>r', opts 'Swap Windows')
key('n', '<leader>wo', '<C-w>o', opts 'Only Window')
key('n', '<leader>w=', '<C-w>=', opts 'Equalize Windows')
key('n', '<leader>wv', '<C-w>v', opts 'Vertical Split')
key('n', '<leader>ws', '<C-w>s', opts 'Horizontal Split')

--Tabs
key('n', '<leader>tn', '<cmd>tabnew<CR>', opts 'Tab New')
key('n', '<leader>tc', '<cmd>tabclose<CR>', opts 'Tab Close')
key('n', '<leader>to', '<cmd>tabonly<CR>', opts 'Tab Only')

-- Navigate buffers
key('n', '<C-n>', ':bnext<CR>', opts 'Buffer Next')
key('n', '<C-p>', ':bprevious<CR>', opts 'Buffer Previous')
key('n', '<C-6>', '<C-^', opts 'Alternate Buffer')
key('n', '<leader>bn', ':bnext<CR>', opts 'Buffer Next')
key('n', '<leader>bp', ':bprevious<CR>', opts 'Buffer Previous')
key('n', '<leader>ba', '<C-^', opts 'Buffer Previous')
--Save buffers
key({ 'n', 'v' }, '<leader>bs', '<cmd>write<CR>', opts 'Write Buffer')
key({ 'n', 'v' }, '<leader>bS', '<cmd>wall<CR>', opts 'Write all Buffers')
key({ 'n', 'v' }, '<leader>bw', '<cmd>write<CR>', opts 'Write Buffer')
key({ 'n', 'v' }, '<leader>bW', '<cmd>wall<CR>', opts 'Write all Buffers')
key({ 'n', 'v' }, '<C-s>', '<cmd>write<CR>', opts 'Write Buffer')
key({ 'n', 'v' }, '<C-S>', '<cmd>wall<CR>', opts 'Write all Buffers')

-- Close buffers
-- switch to prev buffer then delete prev buffer [ bdelete# ]
-- That way splits dont close
key('n', '<leader>bd', '<cmd>bprevious<bar>bdelete#!<CR>', opts 'Delete Buffer (Discard Changes)')
key('n', '<leader>bD', '<cmd>bprevious<bar> %bdelete!<CR>', opts  'Delete All Buffer (Discard Changes)')
key('n', '<leader>bc', '<cmd>write<bar>bprevious<bar>bdelete#<CR>', opts 'Write & Delete Buffer')
key('n', '<leader>bC', '<cmd>wall<bar> %bdelete<CR>', opts 'Write & Delete Buffers')
key('n', '<leader>bqq', '<cmd>q!<CR>', opts 'Quit Buffer')
key('n', '<leader>bQQ', '<cmd>qa!<CR>', opts 'Quit All Buffers')

-- Clear highlights
key('n', '<leader>x', '<cmd>nohlsearch<cr>', opts 'clear search highlight')

-- better paste
key('v', 'p', '"_dp', opts())

-- insert --
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

-- DAP
key('n', '<leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts 'Toggle [b]reakpoint')
key('n', '<leader>dc', "<cmd>lua require'dap'.continue()<cr>", opts '[c]ontinue')
key('n', '<leader>di', "<cmd>lua require'dap'.step_into()<cr>", opts 'Step [i]nto')
key('n', '<leader>do', "<cmd>lua require'dap'.step_over()<cr>", opts 'Step [o]ver')
key('n', '<leader>dO', "<cmd>lua require'dap'.step_out()<cr>", opts 'Step [O]ut')
key('n', '<leader>dr', "<cmd>lua require'dap'.repl.toggle()<cr>", opts '[r]epl toggle')
key('n', '<leader>dl', "<cmd>lua require'dap'.run_last()<cr>", opts 'Run [l]ast')
key('n', '<leader>dd', "<cmd>lua require'dapui'.toggle()<cr>", opts 'DAP UI Toggle')
key('n', '<leader>dt', "<cmd>lua require'dap'.terminate()<cr>", opts 'DAP [t]errminate')

-- Lsp
key('n', '<leader>co', '<cmd>TypescriptOrganizeImports<cr>', opts 'Typescript [o]rganize imports')
key('n', '<leader>cx', '<cmd>TypescriptRemoveUnused<cr>', opts 'Typescript remove unused')
