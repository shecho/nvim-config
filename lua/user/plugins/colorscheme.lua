return {
  -- {
  --   "navarasu/onedark.nvim",
  --   -- priority = 1000,
  --   lazy = false,
  --   -- config = function()
  --   --   vim.cmd([[colorscheme onedark]])
  --   -- end,
  --   opts = function()
  --     --      dark = { -- dark theme palete
  --     -- 	bg0 = "#282c34",
  --     -- 	bg_d = "#21252b",
  --     -- 	bg_blue = "#73b8f1",
  --     -- 	bg_yellow = "#ebd09c",
  --     -- 	fg = "#abb2bf",
  --     -- 	purple = "#c678dd",
  --     -- 	green = "#98c379",
  --     -- 	orange = "#d19a66",
  --     -- 	blue = "#61afef",
  --     -- 	yellow = "#e5c07b",
  --     -- 	cyan = "#56b6c2",
  --     -- 	grey = "#5c6370",
  --     -- 	light_grey = "#848b98",
  --     -- 	dark_cyan = "#2b6f77",
  --     -- 	dark_yellow = "#93691d",
  --     -- 	dark_purple = "#8a3fa0",
  --     -- 	diff_add = "#31392b",
  --     -- 	diff_delete = "#382b2c",
  --     -- 	diff_change = "#1c3448",
  --     -- 	diff_text = "#2c5372",
  --
  --     -- 	red2 = "#e86671",
  --     -- 	black = "#181a1f",
  --     -- 	bg1 = "#31353f",
  --     -- 	bg2 = "#393f4a",
  --     -- 	bg3 = "#3b3f4c",
  --     -- 	bg_blue = "#73b8f1",
  --     -- 	dark_cyan = "#2b6f77",
  --     -- 	dark_red = "#993939",
  --     -- 	dark_yellow = "#93691d",
  --     -- 	dark_purple = "#8a3fa0",
  --     -- },
  --     require("onedark").setup({
  --       style = "dark",
  --       transparent = false,
  --       term_colors = true,
  --       ending_tildes = false,
  --       cmp_itemkind_reverse = false,
  --       toggle_style_key = "<leader>aA",
  --       toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer" }, -- List of styles to toggle between
  --       code_style = {
  --         comments = "bolditalic",
  --         keywords = "italic",
  --         -- functions = "bold",
  --         strings = "bold",
  --         -- variables = 'bold',
  --       },
  --       lualine = {
  --         transparent = true, -- lualine center bar transparency
  --       },
  --       -- Custom Highlights --
  --       colors = { blue2 = "#526fff" }, --cyan = "#e06c75"
  --       highlights = {
  --         -- General
  --         -- ["Identifier"] = { fmt = "bold" },
  --         -- ["Constant"] = { fg = "$red", fmt = "bold" },
  --         -- ["@none"] = { fg = "$red", bg = "$black", fmt = "bold" }, coomont words
  --         -- ["@spell"] = { fg = "$red", bg = "$black", fmt = "bold" },
  --         ["CursorLine"] = { fmt = "bolditalic" },
  --         ["Directory"] = { fmt = "bold" },
  --         ["MatchParen"] = { fg = "$red", bg = "$bg0", fmt = "bolditalic,underline" },
  --         ["TabLine"] = { fmt = "bolditalic" },
  --         ["Keyword"] = { fg = "$purple", fmt = "italic" },
  --         ["Include"] = { fg = "$purple", fmt = "italic" },
  --         ["Visual"] = { fmt = "bolditalic" },
  --
  --         -- Contex
  --         ["@attribute"] = { fg = "$purple", fmt = "italic" },
  --         ["@string"] = { fmt = "bold" },
  --         ["@repeat"] = { fg = "$purple", fmt = "italic" },
  --
  --         ["@type"] = { fmt = "bold" },
  --         ["@type.builtin"] = { fmt = "bold" },
  --         ["@type.definition"] = { fmt = "bold,underline" },
  --
  --         ["@function.builtin"] = { fg = "$blue2", fmt = "bolditalic" },
  --         ["@function.method"] = { fg = "$blue2", fmt = "italic" },
  --         ["@function.macro"] = { fg = "$cyan", fmt = "italic" },
  --
  --         ["@method"] = { fg = "$blue2", fmt = "italic" },
  --
  --         ["@interface"] = { fg = "$orange", fmt = "bolditalic" },
  --         ["@include"] = { fg = "$purple", fmt = "italic" },
  --
  --         ["@constant"] = { fg = "$green", fmt = "bold" },
  --         ["@constant.builtin"] = { fg = "$purple", fmt = "bold" },
  --         ["@constant.macro"] = { fg = "$purple", fmt = "bold" },
  --
  --         ["@keyword"] = { fg = "$purple", fmt = "italic" },
  --         ["@keyword.conditional"] = { fg = "$purple", fmt = "italic" },
  --         ["@keyword.directive"] = { fg = "$purple", fmt = "italic" },
  --         ["@keyword.exception"] = { fg = "$purple", fmt = "italic" },
  --         ["@keyword.function"] = { fg = "$purple", fmt = "italic" },
  --         ["@keyword.import"] = { fg = "$purple", fmt = "italic" },
  --         ["@keyword.repeat"] = { fg = "$purple", fmt = "italic" },
  --         -- ["@keyword.operator"] = { fg = "$purple", fmt = "italic,reverse" },
  --         ["@operator"] = { fg = "$purple" },
  --
  --         ["@label"] = { fg = "$green", fmt = "bold,underline" },
  --
  --         ["@parameter"] = { fg = "$purple", fmt = "bolditalic" },
  --         ["@parameter.reference"] = { fg = "$purple", fmt = "bolditalic,undercurl" },
  --
  --         ["@property"] = { fg = "$red", fmt = "bold" },
  --         ["@property.json"] = { fg = "$red", fmt = "bold" },
  --
  --         ["@punctuation.delimiter"] = { fmt = "bold" },.ts
  --         ["@punctuation.bracket"] = { fmt = "bold" },
  --         ["@punctuation.specifies"] = { fg = "$purple", fmt = "bold" },
  --
  --         ["@boolean"] = { fg = "$orange", fmt = "bolditalic" },
  --
  --         ["@tags"] = { fg = "$green", fmt = "bold" },
  --         ["@tag"] = { fg = "$yellow", fmt = "bold" },
  --         ["@tag.delimiter"] = { fg = "$fg", fmt = "bold" },
  --         ["@tag.attribute"] = { fg = "$orange", fmt = "bold" },
  --
  --         ["@variable"] = { fmt = "bold" },
  --         ["@variable.builtin"] = { fmt = "italic" },
  --         ["@variable.parameter"] = { fmt = "italic" },
  --         ["@variable.member"] = { fmt = "italic" },
  --
  --         ["@lsp.type.property"] = { fg = "$red", fmt = "italic" },
  --         ["@lsp.type.parameter"] = { fmt = "italic" },
  --
  --         -- tabs BarBar
  --         ["BufferCurrentIndex"] = { fg = "$fg", bg = "$bg0", fmt = "italic" },
  --         ["BufferCurrentBtn"] = { fmt = "italic" },
  --         ["BufferCurrentHINT"] = { fg = "$red", fmt = "italic" },
  --
  --         -- LSP
  --         ["DiagnosticVirtualTextHint"] = { fmt = "bolditalic" },
  --         ["DiagnosticVirtualTextEror"] = { fmt = "bolditalic" },
  --       },
  --       -- Plugins Config --
  --       diagnostics = {
  --         darker = true, -- darker colors for diagnostic
  --         undercurl = true, -- use undercurl instead of underline for diagnostics
  --         background = true, -- use background color for virtual text
  --       },
  --     })
  --     require("onedark").load()
  --   end,
  -- },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    opts = {
      colors = {
        blue2 = "#526fff",
        blue3 = "#528bFF",
        bg0 = "#282c34",
        light_grey = "#848b98",
        red2 = "#e86671",
        black = "#181a1f",
        bg_d = "#21252b",
        bg1 = "#31353f",
        bg2 = "#393f4a",
        bg3 = "#3b3f4c",
        bg_blue = "#73b8f1",
        dark_cyan = "#2b6f77",
        dark_red = "#993939",
        dark_yellow = "#93691d",
        dark_purple = "#8a3fa0",
      },
      styles = {
        types = "bold,italic",
        methods = "italic",
        numbers = "bold",
        strings = "bold",
        comments = "bold,italic",
        keywords = "italic",
        constants = "bold",
        functions = "bold",
        operators = "bold",
        variables = "bold",
        parameters = "italic",
        conditionals = "italic",
        virtual_text = "bold,italic",
      },
      highlights = {

        Comment = { extend = true, italic = true, fg = "${comment}" },
        TodoFgFix = { extend = true, link = "comment" },
        TodoFgTodo = { extend = true, link = "comment" },

        LineNr = { bg = "${bg}", extend = true, italic = true },
        -- BufferCurrent = { fg = "${blue}", bg = "${blue}", bold = true, italic = true, extend = true },
        Visual = { bold = true, italic = true, extend = true },
        -- Constant = { fg = "${red}", bold = true },
        Special = { fg = "${red}", bold = true, extend = true },
        Identifier = { bold = true },
        Directory = { bold = true },
        MatchParen = { fg = "${red}", bold = true, italic = true, undercurl = true },
        TabLine = { bold = true, italic = true },
        Keyword = { fg = "${purple}", italic = true },
        Include = { fg = "${purple}", italic = true },

        ["CursorLine"] = { italic = true, bold = true, link = "visual" },
        ["@attribute"] = { fg = "${purple}", italic = true },
        ["@string"] = { bold = true, fg = "${green}" },
        ["@string.scape"] = { bold = true, fg = "${git_add}" },
        ["@string.special"] = { extend = true, italic = true, bold = true },
        ["@string.special.path"] = { extend = true, bold = true, fg = "${git_add}", italic = true },
        ["@string.special.url"] = { extend = true, bold = true, fg = "${git_add}", italic = true, undercurl = true },
        ["@repeat"] = { fg = "${purple}", italic = true },

        ["@type"] = { fg = "${yellow}", bold = true },
        ["@type.builtin"] = { fg = "${orange}", italic = true, bold = true },
        ["@type.builtin.tsx"] = { fg = "${orange}", italic = true, bold = true },
        ["@type.definition"] = { bold = true },

        ["@function"] = { bold = true },
        ["Function"] = { fg = "${virtual_text_information}", bold = true, extend = true },
        ["@function.builtin"] = { fg = "${blue2}", bold = true, italic = true },
        ["@function.method"] = { fg = "${blue2}", italic = true },
        ["@function.macro"] = { fg = "${cyan}", italic = true },
        ["@function.call"] = { fg = "${virtual_text_information}", bold = false, italic = true, link = "Function" },
        ["@function.call.javascript"] = { fg = "${virtual_text_information}", link = "Function" },
        ["@function.call.tsx"] = { fg = "${virtual_text_information}", link = "Function" },
        -- ["@lsp.typemod.function.declaration"] = {  link = "@function" },

        ["@method"] = { fg = "${blue2}", italic = true },
        ["@interface"] = { fg = "${orange}", bold = true, italic = true },
        ["@include"] = { fg = "${purple}", italic = true },
        ["@constant"] = { fg = "${fg}", bold = true },
        ["@constant.builtin"] = { fg = "${purple}", bold = true },
        ["@constant.macro"] = { fg = "${purple}", bold = true },

        ["@keyword"] = { fg = "${purple}", italic = true },
        ["@keyword.conditional"] = { fg = "${purple}", italic = true },
        ["@keyword.directive"] = { fg = "${purple}", italic = true },
        ["@keyword.exception"] = { fg = "${purple}", italic = true },
        ["@keyword.function"] = { fg = "${purple}", italic = true },

        ["@keyword.operator"] = { fg = "${purple}", italic = true },
        ["@keyword.import"] = { fg = "${purple}", italic = true },
        ["@keyword.repeat"] = { fg = "${purple}", italic = true },

        ["@label"] = { fg = "${green}", bold = true, underline = true },
        ["@operator"] = { fg = "${purple}" },

        ["@parameter"] = { fg = "${purple}", bold = true, italic = true },
        ["@parameter.reference"] = { fg = "${purple}", bold = true, italic = true, undercurl = true },
        ["@property"] = { fg = "${red}", bold = true },
        ["@property.json"] = { fg = "${red}", bold = true },

        ["@punctuation.delimiter"] = { bold = true },
        ["@punctuation.special"] = { fg = "${red}", bold = true },
        ["@punctuation.bracket"] = { fg = "${light_grey}", bold = true },
        ["@punctuation.bracket.tsx"] = { link = "@punctuation.bracket" },
        ["@punctuation.bracket.typescript"] = { link = "@punctuation.bracket" },
        ["@punctuation.specifies"] = { fg = "${purple}", bold = true },

        ["@boolean"] = { fg = "${orange}", bold = true, italic = true },

        ["@tag"] = { fg = "${yellow}", bold = true },
        ["@tag.delimiter"] = { fg = "${fg}", bold = true },
        ["@tag.attribute"] = { fg = "${orange}", bold = true },

        ["@variable"] = { bold = true },
        ["@variable.builtin"] = { italic = true },
        ["@variable.parameter"] = { fg = "${red}", italic = true },
        -- ["@variable.parameter.builtin"] = { fg = "${red}", italic = true },
        ["@variable.member"] = { fg = "${red}", italic = true },

        ["@lsp.type.property"] = { fg = "${red}", italic = true },
        ["@lsp.type.parameter"] = { italic = true },

        ["BufferCurrentIndex"] = { fg = "${fg}", italic = true, extend = true },
        -- ["BufferCurrentBtn"] = { italic = true },
        -- ["BufferCurrentHINT"] = { fg = "${red}", italic = true },
        -- ["BufferLineBackground"] = { bg = "${black}", fg = "${selection}" },

        -- ["DiagnosticVirtualTextWarn"] = { fg = "${dark_yellow}", extend = true, bold = true, italic = true },
        -- ["DiagnosticVirtualTextEror"] = { fg = "${dark_red}", extend = true, bold = true },

        -- ["@lsp.typemod.function.declaration"] = { fg = "${virtual_text_information}", bold = false, italic = false, extend = true },
        -- ["@lsp.mod.declaration"] = { fg = "${virtual_text_information}", bold = false, italic = false, extend = true },

        ["NvimTreeFolderIcon"] = { fg = "${blue}", bold = false, extend = true },
        ["FloatBorder"] = { fg = "${bg}", bg = "${bg}", extend = true },
        ["SnacksPickerBorder"] = { fg = "${bg}", extend = true },
        ["SnacksPickerBoxBorder"] = { fg = "${bg}", extend = true },

        ["IlluminatedWordRead"] = { fg = "#828997", underline = true, italic = true, bold = true, extend = true },
        -- variable icon un cmenu
        ["BlinkCmpKindVariable"] = { fg = "${blue2}", bold = true, extend = true },
        -- specificy overrrides
        -- ["@lsp.typemod.variable.readonly"] = { fg = "${cyan}", bold = true },
        -- ["@lsp.typemod.variable.local"] = { fg = "${bg_blue}", bold = true },
        -- comments
      },
      options = {
        highlight_inactive_windows = true,
        -- transparency = true,
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- { "rose-pine/neovim", name = "rose-pine" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "Mofiqul/dracula.nvim" },
  {
    "vague2k/vague.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        -- optional configuration here
      })
      -- vim.cmd("colorscheme vague")
    end,
  },
}
