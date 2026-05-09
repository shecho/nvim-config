return {
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "L3MON4D3/LuaSnip" },
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    -- Versioned releases use prebuilt binaries; avoid requiring Rust on fresh macOS/WSL installs.
    -- build = 'nix run .#build-plugin',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = "luasnip" },
      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          ---@param cmp table The blink.cmp instance
          ---@return boolean|nil
          function(cmp)
            local menu_visible = cmp.is_menu_visible()
            local snippet_active = cmp.snippet_active()
            local has_words = require("user.core.functions").has_words_before()
            if not menu_visible and not snippet_active then
              return cmp.show_and_insert()
            end
            if snippet_active and not menu_visible then
              return cmp.snippet_forward()
            end
            if menu_visible and has_words then
              return cmp.select_next()
            end
          end,
          -- "show_and_insert_or_accept_single",
          -- "show_and_insert",
          -- "snippet_forward",
          -- "select_next",
          -- "fallback",
          -- "fallback_to_mappings",
        },
        ["<S-Tab>"] = {
          "select_prev",
          -- "snippet_backward",
          "fallback",
          "fallback_to_mappings",
        },
        ["<D-y>"] = { "accept", "fallback" },
        ["<D-j>"] = { "show_and_insert", "select_and_accept", "accept", "select_accept_and_enter", "fallback" },
        ["<C-j>"] = { "accept" },
        ["<C-CR>"] = { "accept", "fallback" },
        -- ["<CR>"] = { "select_and_accept", "accept", "accept_and_enter", "select_accept_and_enter", "fallback_to_mappings", "fallback" },
        ["<CR>"] = { "select_and_accept", "accept", "accept_and_enter", "select_accept_and_enter", "fallback" },
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = "cmdline",
          ["<Tab>"] = {
            "show_and_insert",
            ---@param cmp table The blink.cmp instance
            ---@return boolean|nil
            function(cmp)
              if cmp.is_ghost_text_visible() and not cmp.is_menu_visible() then
                return cmp.accept()
              end
              if not cmp.is_menu_visible() then
                return cmp.accept_and_enter()
              end

              return cmp.select_next()
            end,
            "select_next",
            "select_and_accept",
          },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<D-j>"] = { "accept_and_enter", "accept", "fallback" },
          ["<C-j>"] = { "accept" },
          ["<CR>"] = { "select_accept_and_enter", "select_and_accept", "fallback", "fallback_to_mappings" },
        },
        completion = { ghost_text = { enabled = true }, menu = { auto_show = true } },
      },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        nerd_font_variant = "mono",
      },
      completion = {
        trigger = { prefetch_on_insert = false, show_on_insert = true },
        -- list = { selection = { preselect = true, auto_insert = true } },
        accept = { auto_brackets = { enabled = false } },
        documentation = { auto_show = false, auto_show_delay_ms = 100 },

        menu = {
          winblend = 15,
          draw = {
            treesitter = { "lsp" },
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 }, { "source_name" } },
            components = {
              kind_icon = {
                text = function(ctx)
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local mini_icon, _ = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
                    if mini_icon then
                      return mini_icon .. ctx.icon_gap
                    end
                  end

                  local icon = require("lspkind").symbol_map[ctx.kind] or ""
                  return icon .. ctx.icon_gap
                end,

                highlight = function(ctx)
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local mini_icon, mini_hl = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
                    if mini_icon then
                      return mini_hl
                    end
                  end
                  return ctx.kind_hl
                end,
              },
              kind = {
                -- Optional, use highlights from mini.icons
                highlight = function(ctx)
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local mini_icon, mini_hl = require("mini.icons").get_icon(ctx.item.data.type, ctx.label)
                    if mini_icon then
                      return mini_hl
                    end
                  end
                  return ctx.kind_hl
                end,
              },
            },
          },
        },
      },
      signature = { enabled = true },

      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
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
