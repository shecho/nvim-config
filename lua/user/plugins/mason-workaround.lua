return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonLog", "MasonUninstall", "MasonUpdate" },
    init = function()
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        require("lazy").load({ plugins = { "mason-tool-installer.nvim" } })
        vim.cmd("MasonToolsInstall")
      end, { desc = "Install configured Mason packages" })
    end,
    opts = {},
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    lazy = true,
    opts = { automatic_enable = false },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = {
        "stylua",
        "prettierd",
        "prettier",
        "isort",
        "black",
        "lua-language-server",
        "typescript-language-server",
        "vscode-eslint-language-server",
        "emmet-ls",
        "tailwindcss-language-server",
      },
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 5,
      auto_update = false,
    },
    config = function(_, opts)
      local installer = require("mason-tool-installer")
      installer.setup(opts)
      installer.run_on_start()
    end,
  },
}
