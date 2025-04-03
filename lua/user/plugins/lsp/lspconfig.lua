return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "saghen/blink.cmp" },
    -- { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local keymap = vim.keymap.set
    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        local opts = { noremap = true, silent = true, buffer = ev.buf }

        -- keymap.set("n", "<leader>lS", "<cmd>FzfLua lsp_references<CR>", opts)
        -- keymap.set("n", "<leader>lr", vim.lsp.buf.references, opts)
        opts.desc = "Show LSP references"
        keymap("n", "<leader>lr", "<cmd>Trouble lsp_references<CR>", opts)
        keymap("n", "<leader>lS", "<cmd>FzfLua lsp_references<CR>", opts)

        opts.desc = "Show LSP definitions"
        keymap("n", "<leader>ld", "<cmd>Trouble lsp_definitions<CR>", opts)
        keymap("n", "<leader>lD", vim.lsp.buf.definition, opts)

        opts.desc = "Show LSP implementations"
        -- keymap("n", "<leader>lI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        keymap("n", "<leader>li", "<cmd>Trouble lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap("n", "<leader>lT", "<cmd>Trouble lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap({ "n", "v" }, "<leader>lq", vim.lsp.buf.code_action, opts)
        keymap({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)

        opts.desc = "Rename"
        keymap("n", "<leader>le", vim.lsp.buf.rename, opts)
        keymap("n", "<leader>lR", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap("n", "<leader>lD", "<cmd>Trouble diagnostics bufnr=0<CR>", opts)

        opts.desc = "Go to previous diagnostic"
        keymap("n", "<leader>ln", function()
          vim.diagnostic.jump({ count = -1, float = true })
        end, opts)

        opts.desc = "Go to next diagnostic"
        keymap("n", "<leader>ll", function()
          vim.diagnostic.jump({ count = 1, float = true })
        end, opts)

        opts.desc = "Show documentation under cursor"
        keymap("n", "K", vim.lsp.buf.hover, opts)
        keymap("n", "<leader>k", vim.lsp.buf.hover, opts)

        opts.desc = "Format"
        keymap("n", "<leader>lf", vim.lsp.buf.format, opts) -- nnoremap <leader>lf :lua vim.lsp.buf.format({async = true})<CR>
      end,
    })
    -- local on_attach = function(_, bufnr)
    --   local opts = { noremap = true, silent = true, buffer = bufnr }
    --   opts.buffer = bufnr
    --   opts.desc = "Show LSP references"
    --   -- keymap.set("n", "<leader>lS", "<cmd>FzfLua lsp_references<CR>", opts)
    --   -- keymap.set("n", "<leader>lr", vim.lsp.buf.references, opts)
    --   keymap.set("n", "<leader>lr", "<cmd>Trouble lsp_references<CR>", opts)
    --   keymap.set("n", "<leader>lS", "<cmd>FzfLua lsp_references<CR>", opts)
    --
    --   opts.desc = "Show LSP definitions"
    --   keymap.set("n", "<leader>ld", "<cmd>Trouble lsp_definitions<CR>", opts)
    --   keymap.set("n", "<leader>lD", vim.lsp.buf.definition, opts)
    --
    --   opts.desc = "Show LSP implementations"
    --   -- keymap.set("n", "<leader>lI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    --   keymap.set("n", "<leader>li", "<cmd>Trouble lsp_implementations<CR>", opts)
    --
    --   opts.desc = "Show LSP type definitions"
    --   keymap.set("n", "<leader>lT", "<cmd>Trouble lsp_type_definitions<CR>", opts)
    --
    --   opts.desc = "See available code actions"
    --   keymap.set({ "n", "v" }, "<leader>lq", vim.lsp.buf.code_action, opts)
    --   keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
    --
    --   opts.desc = "Rename"
    --   keymap.set("n", "<leader>le", vim.lsp.buf.rename, opts)
    --   keymap.set("n", "<leader>lR", vim.lsp.buf.rename, opts)
    --
    --   opts.desc = "Show buffer diagnostics"
    --   keymap.set("n", "<leader>lD", "<cmd>Trouble diagnostics bufnr=0<CR>", opts)
    --
    --   opts.desc = "Go to previous diagnostic"
    --   keymap.set("n", "<leader>ln", function()
    --     vim.diagnostic.jump({ count = -1, float = true })
    --   end, opts)
    --
    --   opts.desc = "Go to next diagnostic"
    --   keymap.set("n", "<leader>ll", function()
    --     vim.diagnostic.jump({ count = 1, float = true })
    --   end, opts)
    --
    --   opts.desc = "Show documentation under cursor"
    --   keymap.set("n", "K", vim.lsp.buf.hover, opts)
    --   keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
    --
    --   opts.desc = "Format"
    --   keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts) -- nnoremap <leader>lf :lua vim.lsp.buf.format({async = true})<CR>
    -- end

    local capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    }

    local _, blink_cmp = pcall(require, "blink.cmp")

    capabilities = blink_cmp.get_lsp_capabilities(capabilities)

    local signs = {
      Error = " ",
      Warn = " ",
      Hint = " ", -- "󰠠 "
      Info = " ",
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      -- ["svelte"] = function()
      --   -- configure svelte server
      --   lspconfig["svelte"].setup({
      --     capabilities = capabilities,
      --     on_attach = function(client, bufnr)
      --       vim.api.nvim_create_autocmd("BufWritePost", {
      --         pattern = { "*.js", "*.ts" },
      --         callback = function(ctx)
      --           -- Here use ctx.match instead of ctx.file
      --           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
      --         end,
      --       })
      --     end,
      --   })
      -- end,
      ["graphql"] = function()
        lspconfig["graphql"].setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
      end,
      ["emmet_ls"] = function()
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          -- settings = {
          --   Lua = {
          --     -- make the language server recognize "vim" global
          --     diagnostics = {
          --       globals = { "vim" },
          --     },
          --     completion = {
          --       callSnippet = "Replace",
          --     },
          --   },
          -- },
        })
      end,
      ["ts_ls"] = function()
        lspconfig["ts_ls"].setup({
          capabilities = capabilities,
          on_attach = function(client, _)
            client.server_capabilities.document_formatting = false
            client.server_capabilities.document_range_formatting = false
          end,
        })
      end,
    })
  end,
}
