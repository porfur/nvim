-----------------------------------------------------------------------------------
--MY KEYMAPS
-----------------------------------------------------------------------------------
-- Escape with jk
vim.keymap.set('i', 'kj', '<Esc>')


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-- BUFFERS
-----------------------------------------------------------------------------------
-- TODO Male ot work with command - S
--
-- Save
vim.keymap.set({ 'n', 'v' }, '<leader>bs', ':w<CR>', { desc = '[ :w ] Save Buffer' })
vim.keymap.set({ 'n', 'v' }, '<leader>bS', ':wa<CR>', { desc = '[ :wa ] Save all Buffer' })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-s>', ':w<CR>', { desc = '[ :w ] Save Buffer' })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-S>', ':wa<CR>', { desc = '[ :wa ] Save all Buffer' })

-- Close
   vim.keymap.set({ 'n', 'v' }, '<leader>bc', ':bd<CR>', { desc = '[ :bd ] Delete Buffer' })
vim.keymap.set({ 'n', 'v' }, '<leader>bC', ':%bd<CR>', { desc = '[ :%bd ] Delete All Buffers' })
vim.keymap.set({ 'n', 'v' }, '<leader>bk', ':bd!<CR>', { desc = '[ :bd! ] Kill Buffer' })
vim.keymap.set({ 'n', 'v' }, '<leader>bK', ':%bd!<CR>', { desc = '[ :%bd! ] Kill All Buffers' })

--Debug
vim.keymap.set({ 'n', 'v' }, '<leader>df', function()
	print(vim.bo.filetype)
end, { desc = 'Printfiletype' })
vim.keymap.set({ 'n', 'v' }, '<leader>db', function()
	local b = vim.inspect(vim.api.nvim_list_bufs())
	print(b)
end, { desc = 'Esc Quickfix' })
--Netrw Keymaps
vim.keymap.set({ 'n', 'v', 't' }, '<leader>o-', ':Ex<CR>', { desc = "Open Netrw" })

--NeoTree Keymaps
vim.keymap.set({ 'n', 'v', 't' }, '<leader>op', ':NeoTreeFloatToggle<CR>', { desc = "Open NeoTreeFloat" })

--Split resize
-- vim.keymap.set({ 'n', 'v', 't' }, '–', ':resize -5<CR>', {}) -- Alt -
-- vim.keymap.set({ 'n', 'v', 't' }, '≠', ':resize +5<CR>', {}) -- Alt +
-- vim.keymap.set({ 'n', 'v', 't' }, '—', ':vertical resize -5<CR>', {}) -- Alt Shift -
-- vim.keymap.set({ 'n', 'v', 't' }, '±', ':vertical resize +5<CR>', {}) -- Alt Shift +

--Lazygit
vim.keymap.set({ 'n', 'v' }, '<leader>gg', ':LazyGit<CR>', {})

--Telescope Keymap (already in kickstart.nvim)
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

--Close help and quickfix files with escape
vim.keymap.set({ 'n', 'v' }, '<Esc>', function()
	if vim.bo.filetype == 'qf'
			or vim.bo.filetype == 'help'
	then vim.cmd('bdelete') end
end, { desc = 'Esc Quickfix' })

--Tmux Navigator
-- vim.keymap.set('n', '˙', ':<C-U>TmuxNavigateLeft<cr>', { desc = 'Tmux Navigate Left' })
-- vim.keymap.set('n', '∆', ':<C-U>TmuxNavigateDown<cr>', { desc = 'Tmux Navigate Down' })
-- vim.keymap.set('n', '˚', ':<C-U>TmuxNavigateUp<cr>', { desc = 'Tmux Navigate Up' })
-- vim.keymap.set('n', '¬', ':<C-U>TmuxNavigateRight<cr>', { desc = 'Tmux Navigate Right' })
