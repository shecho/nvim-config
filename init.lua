if vim.fn.has("nvim-0.11") == 0 then
  vim.api.nvim_err_writeln("This config requires Neovim 0.11 or newer")
  return
end

if vim.loader then
  vim.loader.enable()
end

require("user.options")
require("user.core")
require("user.keymaps")
require("user.lazy")

-- Colorscheme (set after plugins load)
if not pcall(vim.cmd.colorscheme, "onedark") then
  vim.notify("Failed to load colorscheme: onedark", vim.log.levels.WARN)
end
-- VM theme
vim.g.VM_theme = "purplegray"

-- Window/popup transparency blend
vim.o.winblend = 5
vim.o.pumblend = 5

-- Optional: Uncomment to enable transparent background
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
