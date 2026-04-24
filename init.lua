if vim.loader then
  vim.loader.enable()
end

require("user.options")
require("user.core")
require("user.keymaps")
require("user.lazy")

-- Colorscheme (set after plugins load)
vim.cmd.colorscheme("onedark")
-- VM theme
vim.g.VM_theme = "purplegray"

-- Window/popup transparency blend
vim.o.winblend = 5
vim.o.pumblend = 5

-- Optional: Uncomment to enable transparent background
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
