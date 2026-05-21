return {
  {
    "stevearc/conform.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    event = { "BufReadPre" },
    opts = function()
      local conform = require("conform")
      local uv = vim.uv

      vim.keymap.set({ "n", "v" }, "<leader>lf", function()
        conform.format({
          lsp_format = "fallback",
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format file or range (in visual mode)" })

      ---@module "conform"
      ---@type conform.setupOpts
      return {
        default_format_opts = {
          timeout_ms = 3000,
          async = false,
          quiet = false,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          javascript = { "prettierd", "prettier", stop_after_first = true },
          typescript = { "prettierd", "prettier", stop_after_first = true },
          javascriptreact = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
          svelte = { "prettierd", "prettier", stop_after_first = true },
          css = { "prettierd", "prettier", stop_after_first = true },
          html = { "prettierd", "prettier", stop_after_first = true },
          json = { "prettierd", "prettier", stop_after_first = true },
          yaml = { "prettierd", "prettier", stop_after_first = true },
          markdown = { "prettierd", "prettier", stop_after_first = true },
          graphql = { "prettierd", "prettier", stop_after_first = true },
          liquid = { "prettierd", "prettier", stop_after_first = true },
          lua = { "stylua" },
          python = { "isort", "black" },
        },
        format_on_save = function(bufnr)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          local stat = filename ~= "" and uv.fs_stat(filename) or nil
          if vim.bo[bufnr].buftype ~= "" or vim.api.nvim_buf_line_count(bufnr) > 5000 or (stat and stat.size > 1.5 * 1024 * 1024) then
            return
          end

          return {
            lsp_format = "fallback",
            async = false,
            timeout_ms = 1000,
          }
        end,
      }
    end,
  },
  -- {
  --   "nvimtools/none-ls.nvim", -- configure formatters & linters
  --   dependencies = {
  --     "nvimtools/none-ls-extras.nvim",
  --   },
  --   event = { "BufReadPre", "BufNewFile" },
  --   opts = function()
  --     local null_ls = require("null-ls")
  --     local formatting = null_ls.builtins.formatting -- to setup formatters
  --     local null_ls_utils = require("null-ls.utils")
  --     local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  --
  --     return {
  --       -- add package.json as identifier for root (for typescript monorepos)
  --       root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
  --       -- setup formatters & linters
  --       sources = {
  --         require("none-ls.diagnostics.eslint_d"),
  --         formatting.prettier, -- js/ts formatter
  --         -- diagnostics.eslint,
  --         -- formatting.prettierd,
  --         formatting.stylua, -- lua formatter
  --         null_ls.builtins.completion.spell, -- diagnostics.eslint,
  --         -- diagnostics.eslint_d.with({ -- js/ts linter
  --         --   condition = function(utils)
  --         --     return utils.root_has_file({
  --         --       ".eslintrc.js",
  --         --       ".eslintrc.cjs",
  --         --     }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
  --         --   end,
  --         -- }), -- diagnostics.eslint_d.with({ -- js/ts linter
  --         --   -- diagnostics_format = "[eslint] #{m}\n(#{c})",
  --         --   condition = function(utils)
  --         --       return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
  --         --   end,
  --         -- }),
  --       },
  --       on_attach = function(current_client, bufnr)
  --         if current_client.supports_method("textDocument/formatting") then
  --           vim.api.nvim_clear_autocmds({
  --             group = augroup,
  --             buffer = bufnr,
  --           })
  --           vim.api.nvim_create_autocmd("BufWritePre", {
  --             group = augroup,
  --             buffer = bufnr,
  --             callback = function()
  --               vim.lsp.buf.format({
  --                 filter = function(client)
  --                   return client.name == "null-ls"
  --                 end,
  --                 bufnr = bufnr,
  --               })
  --             end,
  --           })
  --         end
  --       end,
  --     }
  --   end,
  -- },
}
