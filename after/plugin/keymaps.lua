-- Functions 
function OP_Toggle_Ex ()
	if vim.bo.filetype == 'netrw'
	-- Close Ex
	then
		vim.cmd('Rex')
	else
		-- Open Ex
		vim.cmd('Ex')
	end
end

function OP_q_Ex ()
	if vim.bo.filetype == 'netrw'
		-- Close Ex
	then
		vim.cmd('Rex')
	else
		-- Open Ex
		vim.cmd('q')
	end
end

-- Basic
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set({ 'n','v' }, '<leader>bs',':w<CR>',{desc='Save buffer'})
vim.keymap.set({ 'n','v' }, '<C-s>' ,':w<CR>',{desc='Save buffer'})
vim.keymap.set({ 'n','v' }, '<leader>bS',':wa<CR>',{desc='Save all buffer'})
vim.keymap.set({ 'n','v' }, '<leader>bk',':bdelete<CR>',{desc='Kill buffer'})

--Debug
vim.keymap.set({ 'n','v' }, '<leader>df',function ()
print(vim.bo.filetype)
end,{desc='Printfiletype'})
vim.keymap.set({ 'n','v' }, '<leader>db', function ()
local	b = vim.inspect( vim.api.nvim_list_bufs() )
	print(b)
end,{desc='Esc Quickfix'})
--Netrw Keymaps
vim.keymap.set({  'n','v','t'  }, '<leader>o-', OP_Toggle_Ex, {desc="Open Netrw"})

--NeoTree Keymaps
vim.keymap.set({  'n','v','t'  }, '<leader>op',':NeoTreeFloatToggle<CR>', {desc="Open NeoTreeFloat"})

-- vim.keymap.set({'n','v','t'},'<C-w>j',':resize -5<CR>',{})
-- vim.keymap.set({'n','v','t'},'<leader>k',':resize +5<CR>',{})

--Telescope Keymap (already in kickstart.nvim)
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

--Close help and quickfix files with escape
vim.keymap.set({ 'n','v' }, '<Esc>', function ()
if vim.bo.filetype == 'qf'
	or vim.bo.filetype == 'help'
	then vim.cmd('bdelete') end
end,{desc='Esc Quickfix'})
