return {
  {
    "lewis6991/gitsigns.nvim",
    cmd = { "Gitsigns" },
    -- event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "tpope/vim-fugitive",
    event = { "BufReadPre", "BufNewFile" },
    config = function() end,
    keys = {
      { "<leader>ga", "<cmd>Git add .<cr>", nowait = true, desc = "Add" },
      { "<leader>gc", "<cmd>Git commit<cr>", nowait = true, desc = "Commit" },
      { "<leader>gD", "<cmd>Git diff<cr>", nowait = true, desc = "Diff" },
      { "<leader>gg", "<cmd>Gvdiffsplit<cr>", nowait = true, desc = "Diff split" },
      -- { "<leader>gd", "<cmd>Gdiffsplit<cr>", nowait = true, desc = "Diff split" },
      { "<leader>gp", "<cmd>Git push<cr>", nowait = true, desc = "Push" },
      { "<leader>gP", "<cmd>Git pull<cr>", nowait = true, desc = "Pull" },
    },
  },
  {
    "junegunn/gv.vim",
    -- event = { "BufReadPre", "BufNewFile" },
    cmd = { "GV" },
    keys = {
      { "<leader>gH", "<cmd>GV<cr>", nowait = true, desc = "Git History" },
      { "<leader>gh", "<cmd>GV!<cr>", nowait = true, desc = "Buffer commits" },
    },
    config = function() end,
  },
  -- {
  --   "f-person/git-blame.nvim",
  --   -- event = { "BufReadPre", "BufNewFile" },
  --   cmd = { "GitBlameToggle" },
  --   keys = { { "<leader>gb", "<cmd>GitBlameToggle<cr>", nowait = true, desc = "Git Blame" } },
  --   config = function()
  --     local blame = require("gitblame")
  --     blame.setup({
  --       enabled = false,
  --     })
  --     vim.cmd([[
  --       let g:gitblame_enabled = 0
  --     ]])
  --   end,
  -- },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>UU", "<cmd>UndotreeToggle<cr>", desc = "UndotreeToggle", noremap = true, nowait = true, silent = true },
    },
    -- event = { "BufReadPre", "BufNewFile" },
    cmd = { "UndotreeToggle" },
    config = function() end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      -- Run LazyGit command and set background to transparent
      {
        "<leader>gL",
        "<cmd>LazyGit<cr><cmd>hi LazyGitFloat guibg=NONE guifg=NONE<cr><cmd>setlocal winhl=NormalFloat:LazyGitFloat<cr>",
        desc = "LazyGit",
      },
    },
    config = function()
      vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window (0-100)
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
      vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } -- customize lazygit popup window border characters
      vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
      vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed
      vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
      vim.g.lazygit_config_file_path = {} -- table of custom config file paths
    end,
  },
  -- {
  --   "airblade/vim-gitgutter",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     vim.cmd([[
  --           let g:gitgutter_sign_added              = ''
  --           let g:gitgutter_sign_modified           = '▎'
  --           let g:gitgutter_sign_removed            = ''
  --           let g:gitgutter_sign_removed_first_line = '▎'
  --           let g:gitgutter_sign_modified_removed   = '▎'
  --           let g:gitgutter_preview_win_floating = 1
  --
  --           let g:gitgutter_enabled = 1
  --
  --           highlight GitGutterAdd    guifg=#98c379 ctermfg=2
  --           highlight GitGutterChange guifg=#61afef ctermfg=3
  --           highlight GitGutterDelete guifg=#e06c75 ctermfg=1
  --           ]])
  --   end,
  -- },
}
