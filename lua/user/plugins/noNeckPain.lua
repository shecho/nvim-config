return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  cmd = { "NoNeckPain" },
  keys = {
    { "<leader>aN", "<cmd>NoNeckPain<cr>", desc = "Toggle NoNeckPain" },
  },
  config = function()
    require("no-neck-pain").setup({
      width = 190,
    })
  end,
}
