return {
  "hrsh7th/nvim-cmp",
  -- event = "InsertEnter",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      opts = { history = true, delete_check_events = "TextChanged" },
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-look",
  },
  opts = function()
    local cmp = require("cmp")
    local auto_slect = true
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local keymap = require("cmp.utils.keymap")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    -- require("luasnip.loaders.from_vscode").lazy_load()
    local hl = vim.api.nvim_set_hl
    hl(0, "CmpItemKind", { fg = "#61afef" })
    hl(0, "CmpItemKindColor", { fg = "#528bff" })
    hl(0, "CmpItemKindFunction", { fg = "#c678dd" })
    hl(0, "CmpItemKindConstant", { fg = "#98c379" })
    hl(0, "CmpItemKindSnippet", { fg = "#d19a66" })
    hl(0, "CmpItemKindVariable", { fg = "#526fff" })

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
    vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }

    local feedkey = function(key, mode)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end
    cmp.setup({
      -- preselect = cmp.PreselectMode.None,
      preselect = auto_slect and cmp.PreselectMode.Item or cmp.PreselectMode.None,
      completion = { completeopt = "menu,menuone,preview,noselect" },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif vim.fn.pumvisible() == 1 then
            feedkey("<C-n>")
          elseif cmp.visible() and has_words_before() then
            -- cmp.select_next_item()
            cmp.select_next_item({
              behavior = cmp.SelectBehavior.Select,
            })
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Enter>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            if vim.fn.pumvisible() == 0 then
              vim.api.nvim_feedkeys(keymap.t("<C-z><C-p><C-p>"), "in", true)
            else
              vim.api.nvim_feedkeys(keymap.t("<C-p>"), "in", true)
            end
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping.confirm(),
        ["<D-j>"] = cmp.mapping.confirm(),
        -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        -- ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-j>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<C-l>"] = nil,
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c", "n" }),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
      }),
      sources = cmp.config.sources({
        { name = "luasnip" }, -- snippets
        -- { name = "vsnip" }, -- For vsnip users.
        { name = "nvim_lsp" },
        { name = "lazydev" },
        { name = "path" },
        -- { name = "nvim_lua" },
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
        -- { name = "spell" },
        { name = "path" }, -- file system paths
      }),
      formatting = {
        expandable_indicator = true,
        fields = {
          cmp.ItemField.Abbr,
          cmp.ItemField.Kind,
          cmp.ItemField.Menu,
        },
        format = lspkind.cmp_format({
          maxwidth = 60,
          before = function(entry, vim_item)
            vim_item.menu = ({
              luasnip = "",
              nvim_lsp = "",
              -- nvim_lua = "ﲳ",
              treesitter = "",
              buffer = "﬘",
              path = "ﱮ",
              zsh = "",
              vsnip = "",
              spell = "暈",
            })[entry.source.name]
            return vim_item
          end,
          ellipsis_char = "...",
        }),
      },
      experimental = { ghost_text = false },
      window = {
        documentation = cmp.config.window.bordered({ border = "" }),
        completion = cmp.config.window.bordered({ border = "" }),
      },
    })
    -- vim.cmd([[ autocmd FileType lua lua require'cmp'.setup.buffer { sources = { { name = 'buffer' },{ name = 'nvim_lua'},{name = "nvim_lsp"}},} ]])

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } } }),
    })
    cmp.event:on("menu_opened", function()
      vim.b.copilot_suggestion_hidden = false
    end)
    cmp.event:on("menu_closed", function()
      vim.b.copilot_suggestion_hidden = false
    end)
  end,
}
