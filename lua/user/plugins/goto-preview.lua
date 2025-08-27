return {
  "rmagatti/goto-preview",
  dependencies = { "rmagatti/logger.nvim" },
  event = "BufEnter",
  keys = {
    {
      "gp",
      "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
      noremap = true, -- Do not allow remapping
      desc = "goto preview definition", -- Description for the keybinding
    },
    {
      "q",
      "<cmd>lua require('goto-preview').close_all_win()<CR>",
      noremap = true,
      desc = "close all preview windows",
    },
  },
  -- opts = {},
  config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
}
