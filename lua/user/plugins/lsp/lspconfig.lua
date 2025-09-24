return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "saghen/blink.cmp" },
    { "mason-org/mason-lspconfig.nvim" },
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
    local keymap = vim.keymap.set
    ---@type vim.diagnostic.Opts
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    local group = vim.api.nvim_create_augroup("UserLspConfig", {})
    vim.api.nvim_create_autocmd("LspAttach", {
      group = group,
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
        -- keymap("n", "<leader>lD", vim.lsp.buf.definition, opts)
        --
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

        opts.desc = "Show documentation under cursor"
        keymap("n", "K", vim.lsp.buf.hover, opts)
        keymap("n", "<leader>k", vim.lsp.buf.hover, opts)
        opts.desc = "Format"
        keymap("n", "<leader>lf", vim.lsp.buf.format, opts) -- nnoremap <leader>lf :lua vim.lsp.buf.format({async = true})<CR>
      end,
    })

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
      Hint = " ", -- "󰠠 " Info = " ",
    }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    -- vim.lsp.config"graphql"]{
    --   capabilities = capabilities,
    --   filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    -- })
    vim.lsp.config("emmet_ls", {
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })
    vim.lsp.config("tailwindcss", {
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "jsx", "tsx", "css", "sass", "scss", "less", "svelte" },
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
    })

    -- vim.lsp.config("luals", {
    --   capabilities = capabilities,
    -- })
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      -- client.server_capabilities.document_formatting = false
      -- client.server_capabilities.document_range_formatting = false
      -- end,
    })

    vim.lsp.enable({ "emmet_ls", "tailwindcss", "lua_ls", "ts_ls" })
  end,
}
