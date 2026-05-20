return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local illuminate = require("illuminate")
    illuminate.configure({
      providers = {
        "lsp",
        "regex",
      },
      delay = 200,
      under_cursor = true,
      large_file_cutoff = 2000,   -- disable in files > 2000 lines
      large_file_overrides = {
        providers = { "lsp" },     -- only use LSP in large files, skip regex
      },
      min_count_to_highlight = 2,
    })
  end,
}
