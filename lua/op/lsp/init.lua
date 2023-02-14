local neodev_status_ok, neodev = pcall(require, "neodev")
if not neodev_status_ok then
  return
end

local lspzero_status_ok, lspzero = pcall(require, "lsp-zero")
if not lspzero_status_ok then
  return
end

-- No idea what this does
neodev.setup({})

--
lspzero.preset({
  name = 'recommended',
  set_lsp_keymaps = {
    -- Omit keybinds that are customized below on_attach
    omit = { '<F2>', '<F4>', 'gr', '<C-k>' },
    -- Stops whichkey.nvim from overriding cmp keymaps
    preserve_mappings = false
  }
}
)

-- Add custom keybindings on_attach
lspzero.on_attach(function(_, bufnr)
  local opts = function(desc) return { buffer = bufnr, silent = true, desc = desc or "NEED DESC" } end
  local bind = vim.keymap.set

  bind('n', '<leader>cK', function() vim.lsp.buf.hover() end, opts('[K] Hover info'))
  bind('n', '<leader>ci', function() vim.lsp.buf.signature_help() end, opts('S[i]gnature help (alias: <C-i>)'))
  bind('n', '<C-i>', function() vim.lsp.buf.signature_help() end, opts('S[i]gnature help'))
  bind('n', '<leader>cgd', function() vim.lsp.buf.definition() end, opts('[d]efinition'))
  bind('n', '<leader>cgl', function() vim.diagnostic.open_float() end, opts('Diagnostics in F[l]oating window'))
  bind('n', '<leader>cgD', function() vim.lsp.buf.declaration() end, opts('[D]eclaration'))
  bind('n', '<leader>cgi', function() vim.lsp.buf.implementation() end, opts('[i]mplementation'))
  bind('n', '<leader>cgo', function() vim.lsp.buf.type_definition() end, opts('Symb[o]l type definition'))
  bind('n', '<leader>cgr', require('telescope.builtin').lsp_references, opts('[r]eferences'))
  bind('n', 'gr', require('telescope.builtin').lsp_references, opts('Go to [r]eferences'))
  bind('n', '<leader>c[d', function() vim.diagnostic.goto_prev() end, opts('Previous Diagnostic'))
  bind('n', '<leader>c]d ', function() vim.diagnostic.goto_next() end, opts('Next Diagnostic'))
  bind('n', '<leader>cr', function() vim.lsp.buf.rename() end, opts('[R]ename'))
  bind('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts('[A]ction'))
  bind('n', '<leader>cf', ':LspZeroFormat<CR>', opts('[f]ormat'))
  -- more keybindings...
  bind('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts('[S]ymbols'))
  bind('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts('[a]dd Folder'))
  bind('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts('[r]emove Folder'))
  bind('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    opts('[l]ist folder'))
end)
lspzero.setup()
--Default keymaps of lsp-zero
-- K: Displays hover information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.hover().
-- gd: Jumps to the definition of the symbol under the cursor. See :help vim.lsp.buf.definition().
-- gD: Jumps to the declaration of the symbol under the cursor. Some servers don't implement this feature. See :help vim.lsp.buf.declaration().
-- gi: Lists all the implementations for the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.implementation().
-- go: Jumps to the definition of the type of the symbol under the cursor. See :help vim.lsp.buf.type_definition().
-- gr: Lists all the references to the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.references().
-- <Ctrl-k>: Displays signature information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.signature_help(). If a mapping already exists for this key this function is not bound.
-- <F2>: Renames all references to the symbol under the cursor. See :help vim.lsp.buf.rename().
-- <F4>: Selects a code action available at the current cursor position. See :help vim.lsp.buf.code_action().
-- gl: Show diagnostics in a floating window. See :help vim.diagnostic.open_float().
-- [d: Move to the previous diagnostic in the current buffer. See :help vim.diagnostic.goto_prev().
-- ]d: Move to the next diagnostic. See :help vim.diagnostic.goto_next().
