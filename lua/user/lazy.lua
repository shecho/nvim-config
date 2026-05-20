local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv

for _, plugin in ipairs({
  "2html_plugin",
  "gzip",
  -- "matchparen",
  "netrw",
  "netrwPlugin",
  "tarPlugin",
  "tohtml",
  "tutor",
  "zipPlugin",
}) do
  vim.g["loaded_" .. plugin] = 1
end

if not uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
    error("Failed to bootstrap lazy.nvim")
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "user.plugins" },
    { import = "user.plugins.lsp" },
  },
  install = { colorscheme = { "onedark" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "gzip",
        -- "matchparen",
        "netrwPlugin",
        "rplugin",
        "shada",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  -- automatically check for plugin updates
  -- checker = { enabled = true, notify = false },
  -- change_detection = { notify = false },
})
