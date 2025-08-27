return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local illuminate = require("illuminate")
    illuminate.configure({
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      delay = 180,
      under_cursor = true,
      large_file_cutoff = nil,
      large_file_overrides = nil,
      min_count_to_highlight = 2,
    })
  end,
}
