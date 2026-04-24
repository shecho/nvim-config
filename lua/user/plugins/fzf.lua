return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local keymap = vim.keymap -- for conciseness
      keymap.set("n", "<leader>ss", "<cmd>FzfLua live_grep resume=true<cr>", { desc = "Live Grep" })
      keymap.set("n", "<leader>sM", "<cmd>FzfLua marks<cr>", { desc = "Marks" })
      keymap.set("n", "<leader>F", "<cmd>FzfLua files resume=true<cr>", { desc = "Files" })
      keymap.set("n", "<leader>P", "<cmd>FzfLua files resume=true<cr>", { desc = "Files" })
      keymap.set("n", "<leader>sB", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" })
      keymap.set("n", "<leader>sO", "<cmd>FzfLua oldfiles resume=true<cr>", { desc = "Recent Files" })
      keymap.set({ "n", "v", "x" }, "<leader>sW", "<cmd>FzfLua grep_cword<cr>", { desc = "Word Under Cursor" })
      keymap.set("n", "<leader>sF", "<cmd>lua require('fzf-lua').files({ ['winopts.split'] = 'belowright new' })<cr>", { desc = "Files in Split" })
      -- :FzfLua files winopts.split=belowright\ new
      return { winopts = { height = 0.95, width = 0.90, border = "none", backdrop = 70, preview = { border = "none" } } }
    end,
  },
  {
    "junegunn/fzf",
    build = "./install --bin",
    keys = {
      -- { "<leader>sS", "<cmd>Fzf files<cr>", nowait = true, desc = "Fuzzy find files" },
      { "<leader>sS", "<cmd>Fzf live_grep<cr>", nowait = true, desc = "Live Grep" },
    },
  },
}
