return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    -- Filetypes where lualine should be hidden
    local hidden_filetypes = {
      "lazy",
      "mason",
      "snacks_dashboard",
      "snacks_terminal",
      "neo-tree",
      "Trouble",
      "toggleterm",
      "qf",
    }

    lualine.setup({
      options = {
        theme = "onedark",
        globalstatus = true,
        disabled_filetypes = {
          statusline = hidden_filetypes,
          winbar = hidden_filetypes,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          {
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then
                return ""
              end
              local names = {}
              for _, c in ipairs(clients) do
                table.insert(names, c.name)
              end
              return " " .. table.concat(names, ", ")
            end,
            cond = function()
              return #vim.lsp.get_clients({ bufnr = 0 }) > 0
            end,
            color = { fg = "#98c379" },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
      },
    })
  end,
}
