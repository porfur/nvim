local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
  return
end
whichkey.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
}

whichkey.register({
    ["<leader>b"] = { name = "+ Buffer" },
    ["<leader>c"] = { name = "+ [C]ode (LSP)" },
    ["<leader>g"] = { name = "+ [G]it actions" },
    ["<leader>w"] = { name = "+ [W]indow actions" },
    ["<leader>s"] = { name = "+ [S]earch" },
})
