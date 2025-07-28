-- NOTE: This is the callback for the LspAttach autocommand.
-- Keymaps will be applied only in on the LspAttach event
--
return function(event)
  -- NOTE: Remember that Lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end

  --- Returns a function that tries telescope.builtin[name] or falls back to vim.lsp.buf[name]
  local function lsp_telescope(name)
    return function()
      local ok, builtin = pcall(require, 'telescope.builtin')
      if ok and builtin["lsp_" .. name] then
        builtin["lsp_" .. name]({
          initial_mode = 'normal',
          enble_preview = true,
        })
      else
        local lsp_func = vim.lsp.buf[name]
        if type(lsp_func) == "function" then
          lsp_func()
        else
          vim.notify("No LSP support for: " .. name, vim.log.levels.ERROR)
        end
      end
    end
  end

  local hover_rounded = function() vim.lsp.buf.hover { border = "rounded" } end

  map('K', hover_rounded,  ' Hover')

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  map('grn', ':OPRename<CR>', '[R]e[n]ame')
  map('<leader>cr', ':OPRename<CR>', '[r]ename')

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
  map('<leader>ca', vim.lsp.buf.code_action, 'Code [a]ction', { 'n', 'x' })

  -- Find references for the word under your cursor.
  map('grr', lsp_telescope('references'), '[G]oto [R]eferences')
  map('<leader>cR', lsp_telescope('references'), 'Goto [R]eferences')
  -- map('gr', lsp_telescope('references'), '[g]oto [r]eferences')

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map('gri', lsp_telescope('implementations'), '[G]oto [I]mplementation')
  map('<leader>ci', lsp_telescope('implementations'), 'Goto [i]mplementation')

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map('grd', lsp_telescope('definitions'), '[g]oto [d]efinition')
  map('gd', lsp_telescope('definitions'), '[g]oto [d]efinition')
  map('<leader>cd', lsp_telescope('definitions'), 'Goto [d]efinition')

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map('grD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
  map('<leader>cD', vim.lsp.buf.declaration, 'Goto [D]eclaration')

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map('gO', lsp_telescope('document_symbols'), 'Open Document Symbols')
  map('<leader>cs', lsp_telescope('document_symbols'), 'Open Document [s]ymbols')

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map('gW', lsp_telescope('dynamic_workspace_symbols'), 'Open Workspace Symbols')
  map('<leader>cw', lsp_telescope('dynamic_workspace_symbols'), 'Open Workspace [S}ymbols')

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map('grt', lsp_telescope('type_definitions'), '[G]oto [T]ype Definition')
  map('<leader>ct', lsp_telescope('type_definitions'), 'Goto [t]ype Definition')

  --
  -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
  local function client_supports_method(client, method, bufnr)
    if vim.fn.has 'nvim-0.11' == 1 then
      return client:supports_method(method, bufnr)
    else
      return client.supports_method(method, { bufnr = bufnr })
    end
  end

  local client = vim.lsp.get_client_by_id(event.data.client_id)

  -- The following code creates a keymap to toggle inlay hints in your
  -- code, if the language server you are using supports them
  --
  -- This may be unwanted, since they displace some of your code
  if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
    -- NOTE: Not working for some reason
    map('<leader><Tab>h', function()
      local state = not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
      print('Inlay Hints', state)
      vim.lsp.inlay_hint.enable(state)
    end, 'Toggle inlay [h]ints')
  end
end
