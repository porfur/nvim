-- Toggle functions
return {
  toggle = {
    wrap = function()
      vim.wo.wrap = not vim.wo.wrap
      print('Word wrap ' .. (vim.wo.wrap and 'enabled' or 'disabled'))
    end,

    wildignore = function()
      -- TODO: Make sure this works and fix it
      -- Toggle wildignore for common "ignored" files (like .gitignore)
      local ignore_patterns = {
        '**/.git/**',
        '**/node_modules/**',
        '**/dist/**',
        '**/build/**',
        '**/.next/**',
        '**/.cache/**',
        '**/*.lock',
        '**/*.log',
      }
      local current = vim.opt.wildignore:get()

      if vim.tbl_isempty(current) then
        vim.opt.wildignore = ignore_patterns
        print 'Wildignore: ON (ignoring junk files)'
      else
        vim.opt.wildignore = {}
        print 'Wildignore: OFF (searching everything)'
      end
    end,

    quickfix = function()
      local qf_exists = false
      for _, win in pairs(vim.fn.getwininfo()) do
        if win['quickfix'] == 1 then
          qf_exists = true
        end
      end

      if qf_exists then
        vim.cmd 'cclose'
        vim.cmd 'lclose'
      else
        vim.cmd 'copen'
      end
    end,

    locallist = function()
      local loc_exists = false
      for _, win in pairs(vim.fn.getwininfo()) do
        if win.loclist == 1 then
          loc_exists = true
        end
      end

      if loc_exists then
        vim.cmd 'lclose'
        vim.cmd 'cclose' -- Optional: close quickfix as well if you want
      else
        -- Only open location list if it has items, else warn
        local loclist = vim.fn.getloclist(0)
        if loclist and #loclist > 0 then
          vim.cmd 'lopen'
        else
          vim.notify('No location list available', vim.log.levels.WARN)
        end
      end
    end,

    zoom = function()
      if vim.g.op.zoom == true then
        vim.g.op.zoom = false
        vim.cmd 'wincmd ='
        print 'wincmd ='
      else
        vim.g.op.zoom = true
        vim.cmd 'resize 999 | vertical resize 999'
        print 'resize 999 | vertical resize 999'
      end
    end,
    virtual_text = function()
      local current_virtual_text = vim.diagnostic.config().virtual_text
      vim.diagnostic.config { virtual_text = not current_virtual_text }
      print('Virtual text ' .. (current_virtual_text and 'disabled' or 'enabled'))
    end,
  },
  diagnostic = {
    jump = function(count)
      --TODO: See it this is used and remove if not needed
      return function()
        vim.diagnostic.jump { count = count, wrap = true,float=true }
      end
    end,
  },
  utils = {
    reveal_in_finder = function()
      local path = vim.fn.expand '%:p'
      vim.fn.jobstart({ 'osascript', '-e', string.format([[tell application "Finder" to reveal POSIX file "%s"]], path) }, { detach = true })
      vim.fn.jobstart({ 'osascript', '-e', 'tell application "Finder" to activate' }, { detach = true })
    end,
  },
}
