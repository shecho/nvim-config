return {
  {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  dependencies = {
    -- "neovim/nvim-lspconfig",
    -- "mason-org/mason-lspconfig.nvim",
    -- "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    ensure_installed = {
      "stylua",
    },
  },
  config = function()
    local mason = require("mason")
    -- local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "tsserver",
        "eslint",
        "html",
        "cssls",
        "jsonls",
        "bashls",
        "dockerls",
        "gopls",
      },
    })
  end,
}
