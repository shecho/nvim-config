return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  opts = {
    use_diagnostic_signs = true,
    focus = true,
    -- win = { type = "float" },
    modes = {
      preview_float = {
        mode = "diagnostics",
        preview = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Preview",
          title_pos = "center",
          position = { 0, -2 },
          size = { width = 0.3, height = 0.3 },
          zindex = 200,
        },
      },
      -- test = {
      --   mode = "diagnostics",
      --   preview = {
      --     type = "split",
      --     relative = "win",
      --     position = "right",
      --     size = 0.3,
      --   },
      -- },
      -- float = {
      --   mode = "diagnostics",
      --   preview = {
      --     type = "float",
      --     relative = "editor",
      --     border = "rounded",
      --     title = "Preview",
      --     title_pos = "center",
      --     position = { 0, -2 },
      --     size = { width = 0.3, height = 0.3 },
      --     zindex = 200,
      --   },
      -- },
      -- symbols = { -- Configure symbols mode
      --   win = {
      --     type = "split", -- split window
      --     relative = "win", -- relative to current window
      --     position = "right", -- right side
      --     size = 0.3, -- 30% of the window
      --   },
      -- },
      lsp_definitions = {
        win = {
          type = "split", -- split window
          relative = "win", -- relative to current window
          position = "right", -- right side
          size = 0.30, -- 30% of the window
        },
      },
      lsp_references = {
        win = {
          type = "split", -- split window
          relative = "win", -- relative to current window
          position = "right", -- right side
          size = 0.35, -- 30% of the window
        },
      },
      diagnostics = {
        win = {
          type = "split", -- split window
          relative = "win", -- relative to current window
          position = "right", -- right side
          -- position = "", -- right side
          size = 0.38,
        },
      },
    },
  },
  keys = {
    { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics" },
    { "<leader><space>", "<cmd>Trouble diagnostics toggle win.position=right<cr>", desc = "Diagnostics" },
    { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
    { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Lists" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },
}
