return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        config = function() end,
      },
      "axelvc/template-string.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "nvim-treesitter/nvim-treesitter-refactor",
    },
    config = function()
      local template_string = require("template-string")
      template_string.setup({
        filetypes = {
          "typescript",
          "javascript",
          "typescriptreact",
          "javascriptreact",
          "python",
        },
        jsx_brackets = true,
        remove_template_string = false, -- remove backticks when there are no template string
        restore_quotes = {
          normal = [[']],
          jsx = [["]],
        },
      })
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup({
        modules = {},
        TSConfig = nil,
        sync_install = true,
        highlight = { enable = true },
        autotag = { enable = true, enable_rename = true, enable_close = true, enable_close_on_slash = true },
        ignore_install = { "php", "phpdoc", "sql", "erlang" },
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "tsx",
          "yaml",
          "html",
          "css",
          "prisma",
          "markdown",
          "markdown_inline",
          "graphql",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
        },
        auto_install = true,
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,
          persist_queries = false,
        },
        autopairs = { enable = true },
        indent = { enable = true, disable = { "python", "css", "rust" } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {},
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["am"] = "@function.outer",
            },
            goto_next_end = {
              ["AM"] = "@function.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>on"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>op"] = "@parameter.inner",
            },
          },
        },
        -- refactor = { highlight_current_scope = { enable = false } },
        -- termcolors = {} -- table of colour name strings
      })
    end,
  },
}
