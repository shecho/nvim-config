return {
  "folke/which-key.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.icons",
  },
  event = "VeryLazy",
  opts = {
    preset = "helix",
    plugins = { spelling = true },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add({
      { "<leader>a", group = "Window / UI", icon = { icon = " ", color = "yellow" } },
      { "<leader>b", group = "Buffers", icon = { icon = "󰓩 ", color = "azure" } },
      { "<leader>c", group = "Code / Assist", icon = { icon = "󰘦 ", color = "green" } },
      { "<leader>f", group = "Files", icon = { icon = "󰈔 ", color = "blue" } },
      { "<leader>g", group = "Git", icon = { icon = "󰊢 ", color = "orange" } },
      { "<leader>l", group = "LSP", icon = { icon = "󱖫 ", color = "green" } },
      { "<leader>n", group = "Harpoon", icon = { icon = " ", color = "azure" } },
      { "<leader>m", group = "Marks", icon = { icon = "󰃀 ", color = "azure" } },
      { "<leader>o", group = "Text Objects", icon = { icon = "󰅩 ", color = "blue" } },
      { "<leader>s", group = "Search", icon = { icon = " ", color = "blue" } },
      { "<leader>S", group = "Sessions / Scratch", icon = { icon = " ", color = "purple" } },
      { "<leader>x", group = "Diagnostics / Trouble", icon = { icon = " ", color = "red" } },
      { "<leader>r", group = "Rename / Refactor", icon = { icon = "󰑕 ", color = "green" } },
      { "<leader>U", group = "Toggles / Utility", icon = { icon = "󰔡 ", color = "yellow" } },
      { "<localleader>e", group = "Explorer", icon = { icon = " ", color = "blue" } },
      { "<localleader>p", group = "Projects", icon = { icon = " ", color = "purple" } },
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
