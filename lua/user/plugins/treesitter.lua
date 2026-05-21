return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      {
        "windwp/nvim-ts-autotag",
        opts = {
          opts = {
            enable_close = true, -- Auto close tags
            enable_rename = true, -- Auto rename pairs of tags
            enable_close_on_slash = false, -- Auto close on trailing </
          },
        },
      },
      "axelvc/template-string.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "nvim-treesitter/nvim-treesitter-refactor",
    },
    config = function()
      local function get_first_node(match, capture_id)
        local nodes = match[capture_id]
        if not nodes then
          return nil
        end
        return nodes.range and nodes or nodes[1]
      end

      local function get_parser_from_markdown_info_string(injection_alias)
        local filetype = vim.filetype.match({ filename = "a." .. injection_alias })
        local aliases = {
          ex = "elixir",
          pl = "perl",
          sh = "bash",
          ts = "typescript",
          uxn = "uxntal",
        }
        return filetype or aliases[injection_alias] or injection_alias
      end

      local template_string = require("template-string")
      template_string.setup({
        filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "python" },
        jsx_brackets = true,
        remove_template_string = false, -- remove backticks when there are no template string
        restore_quotes = { normal = [[']], jsx = [["]] },
      })
      local treesitter = require("nvim-treesitter.configs")
      local query = require("vim.treesitter.query")

      -- nvim-treesitter has not fully caught up with Neovim 0.12's directive capture shape.
      query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
        local capture_id = pred[2]
        local node = get_first_node(match, capture_id)
        if not node then
          return
        end
        local injection_alias = vim.treesitter.get_node_text(node, bufnr):lower()
        metadata["injection.language"] = get_parser_from_markdown_info_string(injection_alias)
      end, { force = true })

      query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
        local capture_id = pred[2]
        local node = get_first_node(match, capture_id)
        if not node then
          return
        end
        local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[capture_id] }) or ""
        metadata[capture_id] = metadata[capture_id] or {}
        metadata[capture_id].text = text:lower()
      end, { force = true })

      treesitter.setup({
        modules = {},
        TSConfig = nil,
        sync_install = false,
        highlight = { enable = true },
        -- autotag = { enable = true, enable_rename = true, enable_close = true, enable_close_on_slash = true },
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
        auto_install = false,
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
              -- ["am"] = "@function.outer",
            },
            goto_next_end = {
              -- ["AM"] = "@function.outer",
            },
            goto_previous_start = {
              -- ["[m"] = "@function.outer",
              -- ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              -- ["[]"] = "@class.outer",
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
