return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-TAB>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<TAB>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<leader>bn", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<leader>bp", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "<leader>bB", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "<leader>bN", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      -- { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      -- { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    },
    opts = {
      options = {
        themable = true,
        always_show_bufferline = true,
        -- stylua: ignore
        close_command = function(n) Snacks.bufdelete(n) end,
        -- stylua: ignore
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icons = require("user.icons").diagnostics
          local icon = (level:match("error") and icons.Error or "")
            .. (level:match("warning") and icons.Warning or "")
            .. (level:match("info") and icons.Information or "")
            .. (level:match("hint") and icons.Hint or "")
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "right",
          },
          {
            filetype = "snacks_layout_box",
          },
        },
      },
    },
  },
  -- {
  --   "romgrk/barbar.nvim",
  --   dependencies = {
  --     "lewis6991/gitsigns.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   init = function()
  --     vim.g.barbar_auto_setup = false
  --   end,
  --   opts = {
  --     sidebar_filetypes = {
  --       NvimTree = true,
  --       undotree = { text = "undotree", align = "center" },
  --       ["neo-tree"] = { event = "BufWipeout" },
  --       Outline = { event = "BufWinLeave", text = "symbols-outline", align = "right" },
  --     },
  --     animation = true,
  --     auto_hide = false,
  --     tabpages = false,
  --     closable = true,
  --     clickable = true,
  --     icons = {
  --       buffer_index = true,
  --       button = "✖",
  --       diagnostics = {
  --         [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "" },
  --         [vim.diagnostic.severity.WARN] = { enabled = false },
  --         [vim.diagnostic.severity.INFO] = { enabled = false },
  --         [vim.diagnostic.severity.HINT] = { enabled = true },
  --       },
  --       filetype = { custom_colors = true, enabled = true },
  --       separator = { left = "▎", right = "" },
  --       modified = { button = "●" },
  --       pinned = { button = "📌" },
  --       alternate = { filetype = { enabled = false } },
  --       current = { buffer_index = true },
  --       inactive = { button = "×" },
  --       visible = { modified = { buffer_number = false } },
  --     },
  --     exclude_name = {},
  --     highlight_visible = false,
  --     insert_at_end = true,
  --     insert_at_start = false,
  --     maximum_padding = 1,
  --     minimum_padding = 1,
  --     maximum_length = 50,
  --     semantic_letters = true,
  --     letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
  --     no_name_title = nil,
  --   },
  -- },
}
