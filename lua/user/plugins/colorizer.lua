return {
  "norcalli/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local colorizer = require("colorizer")
    colorizer.setup({ "html", "css", "scss", "sass", "less", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "lua" }, {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = false, -- disable CSS color names ("red", "blue") — expensive pattern matching
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = false, -- avoid re-enabling names via css=true
      css_fn = true, -- CSS *functions* only
    })
  end,
}
