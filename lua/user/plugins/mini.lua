---@diagnostic disable: undefined-global
return {
  "echasnovski/mini.files",
  version = "*",
  opts = {},
  keys = {
    {
      "<localleader>E",
      function()
        MiniFiles.open()
      end,
      desc = "Files",
    },
  },
}
