return {
  "onsails/lspkind.nvim",
  event = "VeryLazy",
  lazy = true,
  config = function()
    local icons = require("user.icons")
    require("lspkind").init({
      -- mode = "symbol_text",
      preset = "codicons",
      symbol_map = {
        Copilot = "",
        Text = icons.kind.Text, -- Text = "",
        Method = icons.kind.Method, -- Method = "M()",
        Function = icons.kind.Function, -- Function = "f()",
        Constructor = icons.kind.Constructor, --Constructor = "",
        Field = icons.kind.Field,
        Variable = icons.kind.Variable, --Variable = "",
        Class = icons.kind.Class,
        Interface = icons.kind.Interface,
        Module = icons.kind.Module,
        Property = icons.kind.Property, -- Property = "ﰠ",
        Unit = icons.kind.Unit, -- Unit = "塞",
        Value = icons.kind.Value,
        Enum = icons.kind.Enum,
        Keyword = icons.kind.Keyword,
        Snippet = icons.kind.Snippet,
        Color = icons.kind.Color, --("")
        File = icons.kind.File,
        Reference = icons.kind.Reference, --"",
        Folder = icons.kind.Folder, --(""),
        EnumMember = icons.kind.EnumMember, --(""),
        Constant = icons.kind.Constant,
        Struct = icons.kind.Struct, -- Struct = "פּ",
        Event = icons.kind.Event,
        Operator = icons.kind.Operator, --"",
        TypeParameter = icons.kind.TypeParameter,
      },
    })
  end,
}
