return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonLog", "MasonUninstall", "MasonUpdate" },
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
    },
    init = function()
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        require("lazy").load({ plugins = { "mason.nvim" } })
        local registry = require("mason-registry")
        local opts = require("lazy.core.config").plugins["mason.nvim"].opts or {}

        registry.refresh(function()
          local missing = {}
          for _, package in ipairs(opts.ensure_installed or {}) do
            if registry.has_package(package) and not registry.is_installed(package) then
              missing[#missing + 1] = package
            end
          end

          if #missing == 0 then
            vim.notify("All configured Mason packages are installed", vim.log.levels.INFO)
            return
          end

          vim.cmd("MasonInstall " .. table.concat(missing, " "))
        end)
      end, { desc = "Install configured Mason packages" })
    end,
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
}
