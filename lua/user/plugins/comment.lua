return {
  -- {
  -- "tpope/vim-commentary",
  -- cmd = "Commentary",
  -- event = { "BufReadPre", "BufNewFile" },
  -- config = function()
  -- vim.cmd([[
  -- vnoremap <silent> <space>/ :call Comment()
  -- vnoremap <silent> <space>3 :Commentary
  -- vnoremap <silent> <leader>/ :Commentary<CR>
  -- autocmd FileType javascript.jsx setlocal commentstring={/*\ %s\ */}
  -- ]])
  -- end,
  -- },
  --
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    -- stylua: ignore
    keys = {
      -- { "<leader>3", function() lua qu end, nowait = true, desc = "Comment", mode = { "n", "v" }, },
    },
    opts = function()
      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
      return { pre_hook = ts_context_commentstring.create_pre_hook() }
    end,
    config = function(_, opts)
      require("Comment").setup(opts)

      local keymap = vim.keymap.set -- for conciseness
      local api = require("Comment.api")
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
      local map_opts = { silent = true, desc = "Comment" }

      -- keymap("n", "<leader>3", api.locked("toggle.linewise.current"), opts)
      -- keymap("v", "<leader>3", api.locked("toggle.linewise.count"), opts)
      -- stylua: ignore
      -- keymap("x", "<leader>3", function() vim.api.nvim_feedkeys(esc, "nx", false) api.locked("toggle.linewise")(vim.fn.visualmode()) end, opts)
      keymap("n", "<leader>/", api.locked("toggle.linewise.current"), map_opts)
      keymap("v", "<leader>/", api.locked("toggle.linewise.count"), map_opts)
      -- stylua: ignore
      keymap("x", "<leader>/", function() vim.api.nvim_feedkeys(esc, "nx", false) api.locked("toggle.linewise")(vim.fn.visualmode()) end, map_opts)
      keymap({ "n", "i" }, "<D-/>", api.locked("toggle.linewise.current"), map_opts)
      keymap("v", "<D-/>", api.locked("toggle.linewise.count"), map_opts)
      -- stylua: ignore
      keymap("x", "<D-/>", function() vim.api.nvim_feedkeys(esc, "nx", false) api.locked("toggle.linewise")(vim.fn.visualmode())
      end, map_opts)
    end,
  },
}
