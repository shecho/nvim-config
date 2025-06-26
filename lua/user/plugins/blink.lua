return {
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
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
    build = "cargo build --release",
    -- build = 'nix run .#build-plugin',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = "luasnip" },
      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          function(cmp)
            if not cmp.is_menu_visible() and not cmp.snippet_active() then
              return cmp.show_and_insert()
            elseif cmp.snippet_active() and not cmp.is_menu_visible() then
              return cmp.snippet_forward()
            elseif require("user.core.functions").has_words_before() then
              return cmp.select_next()
            elseif cmp.is_menu_visible() and require("user.core.functions").has_words_before() then
              return cmp.select_next()
            elseif require("user.core.functions").HAS_WORDS_BEFORE() then
              return cmp.select_next()
            end
          end,
          "select_next",
          "fallback_to_mappings",
          "fallback",
        },
        ["<D-y>"] = { "accept", "fallback" },
        ["<D-j>"] = { "select_and_accept", "fallback" },
        ["<C-j>"] = { "accept" },
        ["<C-CR>"] = { "accept", "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback", "fallback_to_mappings" },
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = "cmdline",
          ["<Tab>"] = {
            function(cmp)
              if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
                return cmp.accept()
              end
              if not cmp.is_menu_visible() then
                return cmp.accept_and_enter()
              end
            end,
            "show_and_insert",
            "select_and_accept",
            "select_next",
          },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<C-j>"] = { "accept" },
          ["<D-j>"] = { "accept_and_enter" },
          ["<CR>"] = { "select_accept_and_enter", "select_and_accept", "fallback", "fallback_to_mappings" },
        },
        completion = { ghost_text = { enabled = true }, menu = { auto_show = true } },
      },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        nerd_font_variant = "mono",
      },
      completion = {
        trigger = { prefetch_on_insert = false, show_on_insert = true, show_on_cmdline = true },
        list = { selection = { preselect = true, auto_insert = true } },
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = false, auto_show_delay_ms = 400 },

        menu = {
          winblend = 15,
          draw = {
            treesitter = { "lsp" },
            columns = { { "item_idx" }, { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 }, { "source_name" } },
            components = {
              item_idx = {
                text = function(ctx)
                  return ctx.idx == 20 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
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
                  local hl = "BlinkCmpKind" .. ctx.kind or require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
                -- highlight = function(ctx)
                --   local hl = ctx.kind_hl
                --   if vim.tbl_contains({ "Path" }, ctx.source_name) then
                --     local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                --     if dev_icon then
                --       hl = dev_hl
                --     end
                --   end
                --   return hl
                -- end,
              },
            },
          },
        },
      },
      signature = { enabled = true },

      sources = {
        default = { "lazydev", "snippets", "lsp", "path", "buffer" },
        providers = {
          -- snippets = {
          --   name = "Snippets",
          --   module = "blink.cmp.sources.snippets",
          --   should_show_items = function(ctx)
          --     return ctx.trigger.initial_kind ~= "."
          --   end,
          --   opts = {
          --     engine = "luasnip",
          --     sources = { "friendly-snippets" },
          --   },
          -- },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            -- score_offset = 100,
          },
          path = {
            opts = {
              get_cwd = function(_)
                return vim.fn.getcwd()
              end,
            },
          },
          buffer = {
            opts = {
              -- get_bufnrs = vim.api.nvim_list_bufs,
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  return vim.bo[bufnr].buftype == ""
                end, vim.api.nvim_list_bufs())
              end,
              -- get_bufnrs = function(bufnr)
              --   return vim.tbl_filter(function(b)
              --     return vim.api.nvim_buf_is_loaded(b) and b ~= bufnr
              --   end, vim.api.nvim_list_bufs())
              -- end,
            },
          },
        },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
  },
}
