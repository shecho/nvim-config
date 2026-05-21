local keymap = vim.keymap.set
---@param bufnr number
local function setup_lsp_keymaps(bufnr)
  local opts = {
    noremap = true,
    silent = true,
    buffer = bufnr,
  }

  -- References
  opts.desc = "Show LSP references"
  keymap("n", "<leader>lr", "<cmd>Trouble lsp_references<CR>", opts)
  opts.desc = "Show LSP references (picker)"
  keymap("n", "<leader>lS", "<cmd>FzfLua lsp_references<CR>", opts)
  keymap("n", "<leader>LS", "<cmd>FzfLua lsp_references<CR>", opts)

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

  -- Rename
  opts.desc = "Rename"
  keymap("n", "<leader>le", vim.lsp.buf.rename, opts)

  -- Diagnostics
  opts.desc = "Show buffer diagnostics"
  keymap("n", "<leader>lD", "<cmd>Trouble diagnostics bufnr=0<CR>", opts)

  opts.desc = "Go to previous diagnostic"
  keymap("n", "<leader>ln", function()
    vim.diagnostic.jump({
      count = -1,
      float = true,
    })
  end, opts)
  keymap("n", "[d", function()
    vim.diagnostic.jump({
      count = -1,
      float = true,
    })
  end, opts)

  opts.desc = "Go to next diagnostic"
  keymap("n", "<leader>ll", function()
    vim.diagnostic.jump({
      count = 1,
      float = true,
    })
  end, opts)
  keymap("n", "]d", function()
    vim.diagnostic.jump({
      count = 1,
      float = true,
    })
  end, opts)

  -- Hover
  opts.desc = "Show documentation under cursor"
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "<leader>k", function()
    vim.lsp.buf.hover({
      close_events = { "CursorMoved", "BufHidden", "InsertCharPre", "BufLeave", "WinLeave", "LspDetach" },
    })
  end, opts)
end

----- "󰠠 "
---@return vim.diagnostic.Opts
local function setup_diagnostics()
  return {
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  }
end

---@return table
local function setup_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument = capabilities.textDocument or {}
  capabilities.textDocument.completion = vim.tbl_deep_extend("force", capabilities.textDocument.completion or {}, {
    completionItem = {
      commitCharactersSupport = false,
      deprecatedSupport = true,
      documentationFormat = { "markdown", "plaintext" },
      insertReplaceSupport = true,
      insertTextModeSupport = {
        valueSet = { 1, 2 },
      },
      labelDetailsSupport = true,
      preselectSupport = false,
      resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits", "command" },
      },
      snippetSupport = true,
      tagSupport = {
        valueSet = { 1 },
      },
    },
    completionList = {
      itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" },
    },
    contextSupport = true,
    insertTextMode = 1,
  })

  local overrides = {}
  overrides.textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = false,
    },
  }
  overrides.workspace = vim.tbl_deep_extend("force", overrides.workspace or {}, {
    fileOperations = {
      didRename = true,
      willRename = true,
    },
  })

  return vim.tbl_deep_extend("force", capabilities, overrides)
end

---@param capabilities table
---@return table<string, table>
local function get_server_configs(capabilities)
  -- Shared flags to debounce LSP text change processing (important on Windows)
  local debounce_flags = {
    debounce_text_changes = 100,
  }

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
      flags = debounce_flags,
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false, -- prevents slow "apply settings?" prompts
            maxPreload = 1000,
            preloadFileSize = 500,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
    ts_ls = {
      capabilities = capabilities,
      flags = debounce_flags,
      filetypes = { "typescriptreact", "javascriptreact", "typescript", "javascript" },
      -- init_options = {
      --   preferences = {
      --     -- includeCompletionsWithSnippetText = true,
      --     includeCompletionsForImportStatements = true,
      --   },
      -- },
    },
    eslint = {
      capabilities = capabilities,
      flags = debounce_flags,
      filetypes = { "typescriptreact", "javascriptreact", "typescript", "javascript" },
      -- Run eslint fix on save instead of formatting
      -- on_attach = function(_, bufnr)
      --   vim.api.nvim_create_autocmd("BufWritePre", {
      --     buffer = bufnr,
      --     command = "EslintFixAll",
      --   })
      -- end,
    },
  }
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          {
            path = "${3rd}/luv/library",
            words = { "vim%.uv" },
          },
          {
            path = "LazyVim",
            words = { "LazyVim" },
          },
          {
            path = "snacks.nvim",
            words = { "Snacks" },
          },
          {
            path = "lazy.nvim",
            words = { "LazyVim" },
          },
        },
      },
    },
  },
  config = function()
    vim.diagnostic.config(setup_diagnostics())

    -- Setup capabilities
    local capabilities = setup_capabilities()

    -- Setup LSP attach autocmd
    local group = vim.api.nvim_create_augroup("UserLspConfig", {
      clear = true,
    })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = group,
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        setup_lsp_keymaps(ev.buf)

        if client and client.supports_method("textDocument/inlayHint") and vim.bo[ev.buf].filetype ~= "vue" then
          vim.lsp.inlay_hint.enable(true, {
            bufnr = ev.buf,
          })
        end

        -- if client and client.supports_method("textDocument/foldingRange") then
        --     vim.api.nvim_buf_call(ev.buf, function()
        --         vim.opt_local.foldmethod = "expr"
        --         vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
        --     end)
        -- end
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
