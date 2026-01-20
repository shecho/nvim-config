if vim.loader then
  vim.loader.enable()
  vim.schedule(function()
    vim.notify("nvim is enabled")
  end)
end

require("user.options")
require("user.core")
require("user.keymaps")
require("user.lazy")

vim.cmd([[
  colorscheme onedark
  let g:VM_theme = 'purplegray'
]])

vim.o.winblend = 5
vim.cmd([[ set rtp+=/opt/homebrew/opt/fzf ]])

-- TODO nvim lint

--   highlight Normal guibg=none
--   highlight NonText guibg=none
--   highlight Normal ctermbg=none
--   highlight NonText ctermbg=none
