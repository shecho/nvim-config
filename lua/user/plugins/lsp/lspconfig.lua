return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "saghen/blink.cmp" },
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    -- local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local lspconfig = require("lspconfig")
    local keymap = vim.keymap
    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      opts.buffer = bufnr
      opts.desc = "Show LSP references"
      -- keymap.set("n", "<leader>lr", vim.lsp.buf.references, opts) -- see available code actions
      keymap.set("n", "<leader>lr", "<cmd>Trouble lsp_references<CR>", opts) -- see available code actions
      keymap.set("n", "<leader>ls", "<cmd>FzfLua lsp_references<CR>", opts) -- show definition, references
      keymap.set("n", "<leader>lS", "<cmd>FzfLua lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Show LSP definitions"
      keymap.set("n", "<leader>ld", "<cmd>Trouble lsp_definitions<CR>", opts) -- show lsp definitions
      keymap.set("n", "<leader>lD", vim.lsp.buf.definition, opts) -- go to declaration

      opts.desc = "Show LSP implementations"
      -- keymap.set("n", "<leader>lI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
      keymap.set("n", "<leader>li", "<cmd>Trouble lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "<leader>lT", "<cmd>Trouble lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>lq", vim.lsp.buf.code_action, opts) -- see available code actions
      keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Rename"
      keymap.set("n", "<leader>le", vim.lsp.buf.rename, opts) -- smart rename
      keymap.set("n", "<leader>lR", vim.lsp.buf.rename, opts) -- see available code actions

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>lD", "<cmd>Trouble diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "<leader>ln", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, opts)

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "<leader>ll", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, opts)
      -- keymap.set("n", "<leader>ll", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
      keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Format"
      keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts) -- nnoremap <leader>lf :lua vim.lsp.buf.format({async = true})<CR>
    end

    local capabilities = {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    }

    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

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

    -- configure html server
    lspconfig["html"].setup({
      capabilities = capabilities,
      -- on_attach = on_attach,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,
    })

    -- configure css server
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,
    })

    -- configure tailwindcss server
    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      -- on_attach = on_attach,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,
    })

    lspconfig["svelte"].setup({
      capabilities = capabilities,
      -- on_attach = on_attach,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,
    })

    lspconfig["prismals"].setup({
      capabilities = capabilities,
      -- on_attach = on_attach,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,
    })

    lspconfig["graphql"].setup({
      capabilities = capabilities,
      -- on_attach = on_attach,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,

      filetypes = {
        "graphql",
        "gql",
        "svelte",
        "typescriptreact",
        "javascriptreact",
      },
    })

    -- configure emmet language server
    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      -- on_attach = on_attach,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,
      filetypes = {
        "html",
        "typescriptreact",
        "javascriptreact",
        "css",
        "sass",
        "scss",
        "less",
        "svelte",
      },
    })

    -- configure python server
    lspconfig["pyright"].setup({
      capabilities = capabilities,
      -- on_attach = on_attach,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,
    })
    lspconfig.clangd.setup({
      capabilities = capabilities,
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
      },
      -- on_attach = on_attach,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,
    })

    lspconfig.flow.setup({
      -- on_attach = on_attach,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,
      capabilities = capabilities,
    })

    lspconfig.eslint.setup({
      capabilities = capabilities,
      -- on_attach = on_attach,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,
    })

    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
      cmd = { "typescript-language-server", "--stdio" },
      -- on_attach = on_attach,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = function(_, bufnr)
        on_attach(_, bufnr)
      end,

      -- settings = {
      --   Lua = {
      --     -- diagnostics = { globals = { "vim" } },
      --     workspace = {
      --       library = {
      --         [vim.fn.expand("$VIMRUNTIME/lua")] = true,
      --         [vim.fn.stdpath("config") .. "/lua"] = true,
      --       },
      --     },
      --   },
      -- },
    })
  end,
}
