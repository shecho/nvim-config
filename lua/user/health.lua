local M = {}

local function executable(name)
  return vim.fn.executable(name) == 1
end

local function executable_any(names)
  for _, name in ipairs(names) do
    if executable(name) then
      return true, name
    end
  end

  return false, nil
end

function M.check()
  local uv = vim.uv or vim.loop

  vim.health.start("user config")

  if vim.fn.has("nvim-0.11") == 1 then
    vim.health.ok("Neovim 0.11+ APIs are available")
  else
    vim.health.error("Neovim 0.11+ is required", "This config uses vim.lsp.config() and vim.lsp.enable().")
  end

  if executable("git") then
    vim.health.ok("git is available")
  else
    vim.health.error("git is missing", "lazy.nvim and plugin updates need git.")
  end

  if executable("rg") then
    vim.health.ok("ripgrep is available")
  else
    vim.health.warn("ripgrep is missing", "Install ripgrep for fast grep pickers and grepprg.")
  end

  if executable("fd") or executable("fdfind") then
    vim.health.ok("fd is available")
  else
    vim.health.warn("fd is missing", "Install fd for faster file finding with fzf-lua/snacks pickers.")
  end

  if executable("curl") then
    vim.health.ok("curl is available")
  else
    vim.health.warn("curl is missing", "blink.cmp and several plugin installers expect curl.")
  end

  if executable("fzf") then
    vim.health.ok("fzf is available")
  else
    vim.health.warn("fzf is missing from PATH", "fzf-lua can use the bundled fzf plugin fallback, but a system fzf is recommended.")
  end

  if executable("tree-sitter") then
    vim.health.ok("tree-sitter CLI is available")
  else
    vim.health.warn("tree-sitter CLI is missing", "Install tree-sitter-cli before updating or installing parsers on fresh systems.")
  end

  local has_compiler, compiler = executable_any({ "cc", "gcc", "clang" })
  if has_compiler then
    vim.health.ok("C compiler is available: " .. compiler)
  else
    vim.health.warn("No C compiler found", "Install build-essential on Ubuntu/WSL or Xcode Command Line Tools on macOS for Treesitter parser builds.")
  end

  if vim.fn.has("wsl") == 1 then
    vim.health.start("WSL")

    local cwd = uv.cwd() or ""
    if cwd:match("^/mnt/") then
      vim.health.warn("Current directory is on /mnt", "For best LSP and picker performance, keep projects inside the Linux filesystem, such as ~/code.")
    else
      vim.health.ok("Current directory is not on /mnt")
    end

    local has_wsl_clipboard = executable("win32yank.exe")
      or (vim.env.WAYLAND_DISPLAY ~= nil and executable("wl-copy") and executable("wl-paste"))
      or (vim.env.DISPLAY ~= nil and executable("xclip"))
      or (executable("clip.exe") and (executable("pwsh.exe") or executable("powershell.exe")))
    if has_wsl_clipboard then
      vim.health.ok("Clipboard provider is available")
    else
      vim.health.warn("No WSL clipboard provider found", "Install win32yank.exe, wl-clipboard, xclip, or make clip.exe plus PowerShell available for system clipboard sync.")
    end
  end

  vim.health.start("formatters")
  local formatters = {
    "stylua",
    "prettierd",
    "prettier",
    "isort",
    "black",
  }

  for _, formatter in ipairs(formatters) do
    if executable(formatter) then
      vim.health.ok(formatter .. " is available")
    else
      vim.health.warn(formatter .. " is missing")
    end
  end

  vim.health.start("LSP servers")
  local servers = {
    "lua-language-server",
    "typescript-language-server",
    "vscode-eslint-language-server",
    "emmet-ls",
    "tailwindcss-language-server",
  }

  for _, server in ipairs(servers) do
    if executable(server) then
      vim.health.ok(server .. " is available")
    else
      vim.health.warn(server .. " is missing")
    end
  end
end

return M
