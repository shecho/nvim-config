return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
      { "<leader>Ue", function() require("edgy").toggle() end, desc = "Edgy Toggle", },
      { "<leader>UE", function() require("edgy").select() end, desc = "Edgy Select Window" },
    },
    ---@module 'edgy'
    ---@param opts Edgy.Config
    opts = function(_, opts)
      -- local optss = {
      --   bottom = {
      --     {
      --       ft = "toggleterm",
      --       size = { height = 0.4 },
      --       filter = function(_, win)
      --         return vim.api.nvim_win_get_config(win).relative == ""
      --       end,
      --     },
      --     {
      --       ft = "noice",
      --       size = { height = 0.4 },
      --       filter = function(_, win)
      --         return vim.api.nvim_win_get_config(win).relative == ""
      --       end,
      --     },
      --     "Trouble",
      --     { ft = "qf", title = "QuickFix" },
      --     {
      --       ft = "help",
      --       size = { height = 20 },
      --       filter = function(buf)
      --         return vim.bo[buf].buftype == "help"
      --       end,
      --     },
      --     { title = "Spectre", ft = "spectre_panel", size = { height = 0.4 } },
      --     { title = "Neotest Output", ft = "neotest-output-panel", size = { height = 15 } },
      --   },
      --   left = { { title = "Neotest Summary", ft = "neotest-summary" } },
      --   right = { { title = "Grug Far", ft = "grug-far", size = { width = 0.4 } } },
      --   -- stylua: ignore
      --   keys = {
      --     ["<c-Right>"] = function(win) win:resize("width", 2) end,  -- increase width
      --     ["<c-Left>"] = function(win) win:resize("width", -2) end,  -- decrease width
      --     ["<c-Up>"] = function(win) win:resize("height", 2) end,    -- increase height
      --     ["<c-Down>"] = function(win) win:resize("height", -2) end, -- decrease height
      --   },
      -- }
      -- trouble
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "trouble",
          filter = function(_, win)
            return vim.w[win].trouble
              and vim.w[win].trouble.position == pos
              and vim.w[win].trouble.type == "split"
              and vim.w[win].trouble.relative == "editor"
              and not vim.w[win].trouble_preview
          end,
        })
      end
      -- snacks terminal
      for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
        opts[pos] = opts[pos] or {}
        table.insert(opts[pos], {
          ft = "snacks_terminal",
          size = { height = 0.4 },
          title = "%{b:snacks_terminal.id}: %{b:term_title}",
          filter = function(_, win)
            return vim.w[win].snacks_win and vim.w[win].snacks_win.position == pos and vim.w[win].snacks_win.relative == "editor" and not vim.w[win].trouble_preview
          end,
        })
      end
      return opts
    end,
  },
}
