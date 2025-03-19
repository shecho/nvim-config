return {
  -- "notjedi/nvim-rooter.lua",
  -- config = function()
  --   require("nvim-rooter").setup({
  --     rooter_patterns = { ".git", ".hg", ".svn" },
  --     trigger_patterns = { "*" },
  --     manual = false,
  --     -- fallback_to_parent = true,
  --     -- silent_chdir = 1,
  --     -- silent_chdir_netrw = 1,
  --     -- silent_chdir_filetype = 1,
  --   })
  -- end,
  "airblade/vim-rooter",
  -- event = { "BufReadPre", "BufNewFile" },
  event = "VeryLazy",

  config = function()
    vim.cmd([[
        let g:rooter_silent_chdir = 1
            ]])
  end,
}
