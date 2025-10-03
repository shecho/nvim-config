---@param bufnr number
local function setup_lsp_keymaps(bufnr)
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- References
  opts.desc = "Show LSP references"
  keymap("n", "<leader>lr", "<cmd>Trouble lsp_references<CR>", opts)
  keymap("n", "<leader>lS", "<cmd>FzfLua lsp_references<CR>", opts)

  -- Definitions
  opts.desc = "Show LSP definitions"
  keymap("n", "<leader>ld", "<cmd>Trouble lsp_definitions<CR>", opts)

  -- Implementations
  opts.desc = "Show LSP implementations"
  keymap("n", "<leader>li", "<cmd>Trouble lsp_implementations<CR>", opts)

  -- Type definitions
  opts.desc = "Show LSP type definitions"
  keymap("n", "<leader>lT", "<cmd>Trouble lsp_type_definitions<CR>", opts)

  -- Code actions
  opts.desc = "See available code actions"
  keymap({ "n", "v" }, "<leader>lq", vim.lsp.buf.code_action, opts)
  keymap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)

  -- Rename
  opts.desc = "Rename"
  keymap("n", "<leader>le", vim.lsp.buf.rename, opts)
  keymap("n", "<leader>lR", vim.lsp.buf.rename, opts)

  -- Diagnostics
  opts.desc = "Show buffer diagnostics"
  keymap("n", "<leader>lD", "<cmd>Trouble diagnostics bufnr=0<CR>", opts)

  opts.desc = "Go to previous diagnostic"
  keymap("n", "<leader>ln", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, opts)
  keymap("n", "[[", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, opts)

  opts.desc = "Go to next diagnostic"
  keymap("n", "<leader>ll", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, opts)
  keymap("n", "]]", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, opts)

  -- Hover
  opts.desc = "Show documentation under cursor"
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "<leader>k", function()
    vim.lsp.buf.hover({
      close_events = { "CursorMoved", "BufHidden", "InsertCharPre", "BufLeave", "WinLeave", "LSPDetach" },
    })
  end, opts)

  -- Format
  opts.desc = "Format"
  keymap("n", "<leader>lf", vim.lsp.buf.format, opts)
end

---@return vim.diagnostic.Opts
local function setup_diagnostics()
  local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  return {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  }
end

---@param base_capabilities table|nil
---@return table
local function setup_capabilities(base_capabilities)
  local capabilities = base_capabilities or {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  }

  local ok, blink_cmp = pcall(require, "blink.cmp")
  if ok then
    capabilities = blink_cmp.get_lsp_capabilities(capabilities)
  end

  return capabilities
end

---@param capabilities table
---@return table<string, table>
local function get_server_configs(capabilities)
  return {
    emmet_ls = {
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "jsx", "tsx", "css", "sass", "scss", "less", "svelte" },
    },
    tailwindcss = {
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "jsx", "tsx", "css", "sass", "scss", "less", "svelte" },
    },
    lua_ls = {
      capabilities = capabilities,
    },
    ts_ls = {
      capabilities = capabilities,
      filetypes = { "typescriptreact", "javascriptreact", "tsx", "jsx", "typescript", "javascript" },
    },
  }
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "saghen/blink.cmp" },
    { "mason-org/mason.nvim" },
    { "mason-org/mason-lspconfig.nvim" },
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "LazyVim", words = { "LazyVim" } },
          { path = "snacks.nvim", words = { "Snacks" } },
          { path = "lazy.nvim", words = { "LazyVim" } },
        },
      },
    },
  },
  config = function()
    vim.diagnostic.config(setup_diagnostics())

    -- Setup capabilities
    local capabilities = setup_capabilities()

    -- Setup LSP attach autocmd
    local group = vim.api.nvim_create_augroup("UserLspConfig", {})
    vim.api.nvim_create_autocmd("LspAttach", {
      group = group,
      callback = function(ev)
        setup_lsp_keymaps(ev.buf)
      end,
    })

    -- Configure and enable servers
    local servers = get_server_configs(capabilities)
    for server, config in pairs(servers) do
      vim.lsp.config(server, config)
    end

    vim.lsp.enable(vim.tbl_keys(servers))
  end,
}
