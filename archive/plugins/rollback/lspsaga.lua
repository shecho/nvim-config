return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
  event = "LspAttach",
  config = function()
    require("lspsaga").setup({
      definitions = {
        keys = {
          edit = "e",
        },
      },
      finder = {
        max_height = 0.95,
        min_width = 90,
        force_max_height = true,
        keys = {
          jump_to = "p",
          vsplit = "s",
          split = "i",
          tabe = "<C-j>",
          expand_or_jump = "<TAB>",
          -- toggle_or_open = "<CR>",
          tabnew = "<ENTER>",
          quit = { "q", "<ESC>" },
          close_in_preview = "<ESC>",
        },
      },
      ui = {
        -- currently only round theme
        theme = "round",
        -- border type can be single,double,rounded,solid,shadow.
        border = "rounded",
        winblend = 5,
        expand = "",
        collaspe = "",
        preview = " ",
        code_action = "",
        -- code_action = "💡",
        diagnostic = "🐞",
        hover = " ",
        -- incoming = " ",
        -- outgoing = " ",
        -- colors = {
        -- float window normal bakcground color
        -- normal_bg = "#3b4048", --#181a1f #4b5263 #3b4048
        -- title background color
        -- title_bg = "#afd700",
        --   red = "#e95678",
        --   magenta = "#b33076",
        --   orange = "#FF8700",
        --   yellow = "#f7bb3b",
        --   green = "#afd700",
        --   cyan = "#36d0e0",
        --   blue = "#61afef",
        --   purple = "#CBA6F7",
        --   white = "#d1d4cf",
        --   black = "#1c1c19",
        -- },
        -- kind = {},
      },
    })
  end,
}
