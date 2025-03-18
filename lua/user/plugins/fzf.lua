return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local keymap = vim.keymap -- for conciseness
      keymap.set("n", "<leader>ss", "<cmd>FzfLua live_grep<cr>", { desc = "Fuzzy find files" })
      keymap.set("n", "<leader>sM", "<cmd>FzfLua marks<cr>", { desc = "Marks" })
      keymap.set("n", "<leader>F", "<cmd>FzfLua files<cr>", { desc = "Find files" })
      keymap.set("n", "<leader>P", "<cmd>FzfLua files<cr>", { desc = "Find files" })
      keymap.set("n", "<leader>sB", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })
      keymap.set("n", "<leader>sO", "<cmd>FzfLua oldfiles<cr>", { desc = "Find oldfiles" })
      keymap.set({ "n", "v", "x" }, "<leader>sW", "<cmd>FzfLua grep_cword<cr>", { desc = "Find current word" })
      keymap.set("n", "<leader>sF", "<cmd>lua require('fzf-lua').files({ ['winopts.split'] = 'belowright new' })<cr>", { desc = "Files system" })
      -- :FzfLua files winopts.split=belowright\ new
      return { winopts = { height = 0.95, width = 0.90 } }
    end,
  },
  {
    "junegunn/fzf",
    build = "./install --bin",
    keys = {
      -- { "<leader>sS", "<cmd>Fzf files<cr>", nowait = true, desc = "Fuzzy find files" },
      { "<leader>sS", "<cmd>Fzf live_grep<cr>", nowait = true, desc = "Fuzzy find files" },
    },
  },
}
