return {
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
          end,
        },
        opts = { history = true, delete_check_events = "TextChanged" },
      },
    },

    version = "1.*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      snippets = { preset = "luasnip" },

      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            elseif vim.fn.pumvisible() == 1 then
              return require("user.core.functions").feedkey("<C-n>")
            elseif cmp.is_menu_visible() and require("user.core.functions").has_words_before() then
              return cmp.select_next()
            elseif cmp.is_menu_visible() then
              return cmp.select_next()
            elseif require("user.core.functions").has_words_before() then
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<C-Z>"] = { "accept", "fallback" },
        ["<D-y>"] = { "accept", "fallback" },
        ["<D-j>"] = { "accept", "fallback" },
        ["<C-j>"] = { "accept", "fallback" },
        ["<C-Enter>"] = { "accept", "fallback" },
        ["<Enter>"] = { "accept", "fallback" },
        ["<C-CR>"] = { "accept", "fallback" },
      },
      cmdline = { completion = { ghost_text = { enabled = false }, menu = { auto_show = true } } },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "normal",
      },
      completion = {
        -- trigger = { prefetch_on_insert = false },
        -- list = { selection = { preselect = false } },
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },

        -- max_width = 20,
        menu = {
          winblend = 35,
          draw = {
            treesitter = { "lsp" },
            columns = { { "item_idx" }, { "label", "label_description", gap = 1 }, { "kind_icon" }, { "source_name" } },
            components = {
              item_idx = {
                text = function(ctx)
                  return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
                end,
                highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
              },
              kind_icon = {
                text = function(ctx)
                  local lspkind = require("lspkind")
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = lspkind.symbolic(ctx.kind, {
                      mode = "symbol",
                    })
                  end

                  return icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },
            },
          },
        },
      },
      signature = { enabled = true },

      sources = {
        default = { "lazydev", "snippets", "lsp", "path", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
