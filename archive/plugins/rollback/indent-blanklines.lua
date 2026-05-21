return {
  "lukas-reineke/indent-blankline.nvim",
  -- cmd = { "IndentBlanklineEnable", "IndentBlanklineToggle", "IndentBlanklineDisable" },
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    -- indent = { highlight = highlight },
    -- char = "▏",
    char = "│",
    filetype_exclude = {
      "help",
      "alpha",
      "dashboard",
      "neo-tree",
      "Trouble",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
      "lazyterm",
      "help",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
      -- "NvimTree",
      "Trouble",
      "text",
    },
    show_trailing_blankline_indent = false,
    show_current_context_start = true,
  },
  config = function()
    -- local highlight = {
    --   "RainbowViolet",
    -- }
    -- local hooks = require("ibl.hooks")
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    -- vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    -- vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    -- vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    -- vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    -- vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    -- vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#7e3992" }) -- C678DD
    -- vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    -- end)
    require("ibl").setup({})
  end,
}
