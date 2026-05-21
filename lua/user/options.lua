vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opt = vim.opt

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if vim.fn.isdirectory(mason_bin) == 1 and not vim.env.PATH:find(mason_bin, 1, true) then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

opt.numberwidth = 4
opt.incsearch = true
opt.hlsearch = true
opt.swapfile = false
-- opt.ttyfast = true
-- opt.lazyredraw = true
opt.backup = false
opt.background = "dark"
opt.autoindent = true
opt.smarttab = true
opt.ruler = true
opt.fileencoding = "utf-8"
opt.autowrite = true -- Enable auto write
local is_wsl = vim.fn.has("wsl") == 1
local has_wsl_clipboard = vim.fn.executable("win32yank.exe") == 1
  or (vim.env.WAYLAND_DISPLAY ~= nil and vim.fn.executable("wl-copy") == 1 and vim.fn.executable("wl-paste") == 1)
  or (vim.env.DISPLAY ~= nil and vim.fn.executable("xclip") == 1)
local powershell = vim.fn.executable("pwsh.exe") == 1 and "pwsh.exe" or (vim.fn.executable("powershell.exe") == 1 and "powershell.exe" or nil)
if is_wsl and not has_wsl_clipboard and vim.fn.executable("clip.exe") == 1 and powershell then
  local paste_cmd =
    { powershell, "-NoLogo", "-NoProfile", "-c", [[$content = Get-Clipboard -Raw; if ($null -ne $content) { [Console]::Out.Write($content.ToString().Replace("`r", "")) }]] }
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = paste_cmd,
      ["*"] = paste_cmd,
    },
    cache_enabled = 0,
  }
  opt.clipboard = "unnamedplus"
elseif not is_wsl or has_wsl_clipboard then
  opt.clipboard = "unnamedplus" -- Sync with system clipboard when a provider is available
end
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = false -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.grepformat = "%f:%l:%c:%m"
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep"
end
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"
opt.laststatus = 3
opt.list = false -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
-- opt.guicursor = "a:block"
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.smoothscroll = true
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 200
opt.undofile = false -- Save undo history
opt.undolevels = 10000
opt.updatetime = 250 -- Balanced: fast enough for CursorHold, not hammering LSP
opt.virtualedit = "block"
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.mousemoveevent = true

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

if vim.g.neovide then
  vim.o.guifont = "Fira Code,Symbols Nerd Font Mono:h34"
  vim.g.neovide_scale_factor = 0.3
end

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"
  opt.shortmess:append({ C = true })
end
vim.g.snacks_animate = false
vim.g.markdown_recommended_style = 0
-- Fix markdown indentation settings
