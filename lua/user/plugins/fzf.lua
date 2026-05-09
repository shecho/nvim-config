return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>ss", "<cmd>FzfLua live_grep resume=true<cr>", desc = "Live Grep" },
      { "<leader>sS", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
      { "<leader>sM", "<cmd>FzfLua marks<cr>", desc = "Marks" },
      { "<leader>F", "<cmd>FzfLua files resume=true<cr>", desc = "Files" },
      { "<leader>P", "<cmd>FzfLua files resume=true<cr>", desc = "Files" },
      { "<leader>sB", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
      { "<leader>sO", "<cmd>FzfLua oldfiles resume=true<cr>", desc = "Recent Files" },
      { "<leader>sW", "<cmd>FzfLua grep_cword<cr>", desc = "Word Under Cursor", mode = { "n", "v", "x" } },
      { "<leader>sF", "<cmd>lua require('fzf-lua').files({ ['winopts.split'] = 'belowright new' })<cr>", desc = "Files in Split" },
    },
    opts = function()
      local fzf_bin = vim.fn.exepath("fzf")
      if fzf_bin == "" then
        local plug_bin = vim.fn.stdpath("data") .. "/lazy/fzf/bin/fzf"
        if vim.fn.executable(plug_bin) == 1 then
          fzf_bin = plug_bin
        end
      end

      return { fzf_bin = fzf_bin ~= "" and fzf_bin or nil, winopts = { height = 0.95, width = 0.90, border = "none", backdrop = 70, preview = { border = "none" } } }
    end,
  },
  {
    "junegunn/fzf",
    build = "./install --bin",
    lazy = true,
  },
}
