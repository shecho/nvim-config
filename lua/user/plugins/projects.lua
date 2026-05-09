return {
  {
    "DrKJeff16/project.nvim",
    -- name = "project_nvim", -- Keep the name consistent for imports
    event = "VeryLazy",
    dependencies = {
      "ibhagwan/fzf-lua",
    },
    opts = {
      history = { save_dir = vim.fn.stdpath("data") },
      lsp = { enabled = true },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
      -- show_hidden = false,
    },
    config = function(_, opts)
      --   require("project_nvim").setup(opts)
      require("project").setup(vim.tbl_deep_extend("force", opts, {
        fzf_lua = {
          enabled = true, -- Will enable the `:ProjectFzfLua` command
        },
        snacks = {
          enabled = true, -- Will enable the `:ProjectSnacks` command
          opts = {
            sort = "newest",
            hidden = false,
            title = "Select Project",
            layout = "select",
            -- icon = {},
            -- path_icons = {},
          },
        },
      }))
    end,
    keys = {
      {
        "<localleader>fp",
        "<cmd>ProjectRecents<cr>",
        desc = "Find Projects",
      },
      {
        "<localleader>fP",
        "<cmd>ProjectFzf<cr>",
        desc = "Find Projects fzf",
      },
    },
  },
  -- {
  --   "jakobwesthoff/project-fzf.nvim",
  --   dependencies = {
  --     -- "ahmedkhalf/project.nvim", -- Must be configured separately
  --     "ibhagwan/fzf-lua",
  --   },
  --   opts = {}, -- Will call require('project-fzf').setup(opts)
  -- },
}
