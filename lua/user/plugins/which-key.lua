return {
  "folke/which-key.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.icons",
  },
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 200
  end,
  opts = {
    plugins = { spelling = true },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      { "<leader>a", group = "Actions/Avante", icon = { icon = "", color = "yellow" } },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Copilot", icon = { icon = " ", color = "green" } },
      { "<leader>f", group = "File" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "Lsp", icon = { icon = "󱖫 ", color = "green" } },
      { "<leader>n", group = "Harpoon", icon = { icon = " ", color = "azure" } },
      { "<leader>m", group = "Harpoon Menu", icon = { color = "azure" } },
      { "<leader>o", group = "Treesitter" },
      { "<leader>s", group = "Search" },
      { "<leader>S", group = "Session", icon = { icon = " ", color = "purple" } },
      { "<leader>x", group = "Trouble" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "Lsp" },
      { "<leader>r", group = "Rename" },
      { "<leader>U", group = "Notify/Toggles" },
    })
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
