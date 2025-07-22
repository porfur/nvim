local M = require('utils')
local map = vim.keymap.set
local hover_rounded = function() vim.lsp.buf.hover { border = "rounded" } end

-- [[ QUALITY OF LIFE: START ]]

-- Press kj fast to ESC can also C-c to escape
map('i', 'kj', '<Esc>')

-- Clear highlights
map('n', '<leader>x', ':nohlsearch<CR>', { desc = 'Clear Search Highlight' })
map('n', '<Esc>', ':nohlsearch<CR>', { desc = 'Clear Search Highlight' })

-- Cycle next/prev command in command mode.
map('c', '<C-n>', '<down>', { desc = 'Next command' })
map('c', '<C-p>', '<up>', { desc = 'Previous command' })

-- Exit terminal mode with C-n C-n (Might not work in some terminals)
-- Default is C-\ C-n
map('t', '<C-n><C-n>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Center cursor on page scroll
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', '<C-f>', '<C-f>zz')
map('n', '<C-b>', '<C-b>zz')

-- Split Line
map('n', '|', 'i<CR><Esc>', { desc = 'Split line (Opposite of J)' })

--Insert New Line in normal mode uses the o mark
map('n', '[o', 'moO<ESC>`o', { desc = 'Empty Line above' })
map('n', ']o', 'moo<ESC>`o', { desc = 'Empty Line below' })

-- Move line in visual mode using J and K
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- visual stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Paste in visual mode doesn't polute the clipboard with the old selection
-- This means you lose the selection you pasted over from the registers
map('v', 'p', '"_dp')

-- yank current file path
map('n', 'yp', ':let @+=expand("%")<CR>', { desc = '[y]ank relative [p]ath to system clipboard' })

-- Open project related files
map('n', '<leader>fg', ':find .gitignore<CR>', { desc = 'Open [f]ile .gitignore' })
map('n', '<leader>fe', ':find .env<CR>', { desc = 'Open [f]ile .env' })
map('n', '<leader>fp', ':find package.json<CR>', { desc = 'Open [f]ile package.json' })

-- macOS quicklook
map('n', 'gq', M.utils.reveal_in_finder, { desc = 'Reveal file in Finder' })

-- [[ QUALITY OF LIFE: END ]]

-- =============================================================================

-- [[ DIAGNOSTICS AND LSP: START ]]
-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings

-- Default is <C-w>d
map('n', 'gl', vim.diagnostic.open_float, { desc = 'Open Diagnostic f[l]oat' })
map('n', ']d', M.diagnostic.jump(1), { desc = 'Next diagnostic float' })
map('n', '[d', M.diagnostic.jump(-1), { desc = 'Prev diagnostic float' })

map('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Open [d]iagnostic (current buffer)' })
map('n', '<leader>D', vim.diagnostic.setqflist , { desc = 'Open [D]iagnostics (all buffers)' })
map('n', 'K', hover_rounded, { desc = 'LSP hover' })

-- [[ DIAGNOSTICS AND LSP: END ]]
-- =============================================================================

-- [[ SESSIONS: START ]]

map('n', '<leader>qs', ':mksession! OPSession.vim<CR>', { desc = 'Make OP [s]ession' })
map('n', '<leader>ql', ':source Session.vim<CR>', { desc = '[l]oad session' })
map('n', '<leader>qL', ':source OPSession.vim<CR>', { desc = '[l]oad OP session' })
map('n', '<leader>qq', ':qa<CR>', { desc = '[q]uit all' })
map('n', '<leader>qQ', ':qa!<CR>', { desc = 'Discard and [q]uit all' })

-- [[ SESSIONS: END ]]

-- =============================================================================

-- [[ TOGGLES: START ]]

map('n', '<C-q>', M.toggle.quickfix, { desc = 'Toggle [q]uickfix' })
map('n', '<leader><Tab>q', M.toggle.quickfix, { desc = 'Toggle [q]uickfix' })
map('n', '<leader><Tab>l', M.toggle.locallist, { desc = 'Toggle [l]ocal list' })
map('n', '<leader><Tab>w', M.toggle.wildignore, { desc = 'Toggle [w]ildignore' })
map('n', '<leader><Tab>r', M.toggle.wrap, { desc = 'Toggle w[r]ap' })
map('n', '<leader><Tab>v', M.toggle.virtual_text, { desc = 'Toggle diagnostic [v]irtual text' })

-- [[ TOGGLES: END ]]

-- =============================================================================

-- [[ WINDOW: START ]]

-- Ctrl-hjkl to navigate windows
map('n', '<C-h>', '<C-w>h', { desc = 'Window Navigate Left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Window Navigate Down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Window Navigate Up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Window Navigate Right' })

-- Resize with Alt-hjkl
map('n', '<M-j>', ':resize -2<CR>', { desc = 'Window Horizontal Shrink' })
map('n', '<M-k>', ':resize +2<CR>', { desc = 'Window Horizontal Grow' })
map('n', '<M-h>', ':vertical resize -2<CR>', { desc = 'Window Vertical Shrink' })
map('n', '<M-l>', ':vertical resize +2<CR>', { desc = 'Window Vertical Grow' })

-- Equalize and maximize M-=
map('n', '<M-\\>', ':vertical resize 999<CR>', { desc = 'Max window width' })
map('n', '<M-|>', ':vertical resize 0<CR>', { desc = 'Min window width' })
map('n', '<M-->', ':resize 999<CR>', { desc = 'Max window height' })
map('n', '<M-_>', ':resize 0<CR>', { desc = 'Min window height' })

-- Zoom toggle
map('n', '<M-Z>', M.toggle.zoom, { desc = 'Max out the height' })
map('n', '<C-w>z', M.toggle.zoom, { desc = 'Max out the height' })

-- [[ WINDOW: END ]]

-- =============================================================================

-- [[ TABS: START ]]
-- TODO: Put index number on tab for easy moving
map('n', '<leader>tn', ':tabnew<CR>', { desc = 'Tab New' })
map('n', '<leader>tc', ':tabclose<CR>', { desc = 'Tab Close' })
map('n', '<leader>tl', ':tabnext<CR>', { desc = 'Tab Next' })
map('n', '<leader>th', ':tabprevious<CR>', { desc = 'Tab Previous' })
map('n', '<leader>to', ':tabonly<CR>', { desc = 'Tab Only' })
map('n', '<leader>tm', ':tabmove', { desc = 'Tab Move' })

-- [[ TABS: END ]]

-- =============================================================================

-- [[ BUFFERS: START ]]

-- Navigate buffers
map('n', '<C-n>', ':bnext<CR>', { desc = 'Buffer Next' })
map('n', '<C-p>', ':bprevious<CR>', { desc = 'Buffer Previous' })
map('n', '<leader>bn', ':bnext<CR>', { desc = 'Buffer Next' })
map('n', '<leader>bp', ':bprevious<CR>', { desc = 'Buffer Previous' })
map('n', '<leader>n', ':bnext<CR>', { desc = 'Buffer Next' })
map('n', '<leader>p', ':bprevious', { desc = 'Buffer Previous' })
map('n', '<leader>ba', '<C-^>', { desc = 'Alternate Buffer' })
map('n', '<leader>a', '<C-^>', { desc = 'Alternate Buffer' })
-- map('n', '<Tab>', '<C-^>', { desc = 'Alternate Buffer' })

-- Save buffers
-- Same commands three different ways
map({ 'n', 'v' }, '<leader>bs', ':write<CR>', { desc = 'Write Buffer' })
map({ 'n', 'v' }, '<leader>bS', ':wall<CR>', { desc = 'Write all Buffers' })

map({ 'n', 'v' }, '<C-s>', ':write<CR>', { desc = 'Write Buffer' })
map({ 'n', 'v' }, '<C-S>', ':wall<CR>', { desc = 'Write all Buffers' })

map({ 'n', 'v' }, '<leader>bw', ':write<CR>', { desc = 'Write Buffer' })
map({ 'n', 'v' }, '<leader>bW', ':wall<CR>', { desc = 'Write all Buffers' })

-- Close buffers
-- Deleting a buffer also closes it's window
-- NOTE: These commands delete buffers maintaining the window layout
-- How it works
-- -- | Chains commands
-- % Refers to all buffers
-- # Refers to the the alternate buffer
-- ! Forces to discard unsaved chages
-- --
-- Calling ':bprevious | bdelete #' on ( Buffer A )
-- - bprevious - switches to the previous buffer ( Buffer B ) making Buffer A the alternate buffer
-- - bdelete # - deletes the alternate buffer ( Buffer A )
map('n', '<leader>bd', ':bprevious|bdelete#!<CR>', { desc = 'Delete Buffer (Discard Changes)' })
map('n', '<leader>bD', ':%bdelete!<CR>', { desc = 'Delete All Buffer (Discard Changes)' })
map('n', '<leader>bc', ':write|bprevious|bdelete#<CR>', { desc = 'Write & Delete Buffer' })
map('n', '<leader>bC', ':wall|%bdelete<CR>', { desc = 'Write & Delete Buffers' })

-- [[ BUFFERS: END ]]

-- =============================================================================

-- [[ MARKS: START ]]

map('n', '<leader>`x', ':marks <CR>:delmarks ', { desc = 'Delete mark...' })
map('n', '<leader>`d', ':delmarks!<CR>', { desc = 'Delete local marks' })
map('n', '<leader>`D', ':delmarks A-Z0-9<CR>', { desc = 'Delete global marks' })
map('n', '<leader>`l', ':marks<CR>', { desc = 'List marks' })

-- [[ MARKS: END ]]

-- =============================================================================

