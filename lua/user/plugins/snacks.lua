return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      image = { enabled = true },
      input = { enabled = true },
      scope = { enabled = true },
      bigfile = { enabled = true, size = 1.5 * 1024 * 1024 },
      quickfile = { enabled = true },
      indent = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = { notification = {}, zen = { width = 0.90, backdrop = { transparent = true, blend = 20 } } },
      explorer = { minimal = true, enabled = true, replace_netrw = true, layout = { position = "right" } },
      zen = { enabled = true, toggles = { dim = false } },
      picker = {
        enabled = true,
        layouts = {
          default = { layout = { width = 0.98, height = 0.98 } },
          vscode = { layout = { width = 0.60 } },
          dropdown = { layout = { width = 0.70 } },
          telescope = { layout = { width = 0.95, height = 0.95 } },
        },
        -- layout = { layout = { box = "horizontal" } },
        sources = {
          command_history = { focus = "list" },
          explorer = { layout = { layout = { position = "right" }, border = "none" } }, -- explorer = { layout = { preset = "right" } }, --  same as
          recent = { layout = { preset = "vscode" }, focus = "list" },
          buffers = { layout = { preset = "vscode" }, focus = "list" }, -- buffers = { layout = { layout = { width = 0.99, height = 0.99 } } },
          marks = { layout = { preset = "telescope" }, focus = "list" },
          files = { layout = { border = "none", preset = "dropdown", layout = { width = 0.99, height = 0.99 } } }, -- files = { layout = { layout = { width = 0.90, height = 0.90 } } },
          projects = { layout = { preset = "select" }, focus = "list" },
          diagnostics_buffer = { layout = { preset = "select" }, focus = "list" },
        },
      },
      dashboard = { enabled = false },
    },
    keys = {
      -- buffer
      {
        "<leader>d",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete buffer",
      },
      {
        "<leader>D",
        function()
          Snacks.bufdelete.delete()
        end,
        desc = "Delere buffer force",
      },
      {
        "<leader>bb",
        function()
          Snacks.bufdelete.other()
        end,
        desc = "Delete other buffers",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      -- search and explorer
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
      {
        "<leader>p",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Files",
      },
      {
        "<leader>sf",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Files",
      },
      {
        "<leader>sb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Highlights",
      },
      {
        "<leader>sh",
        function()
          Snacks.picker.highlights()
        end,
        desc = "Highlights",
      },
      {
        "<leader>sc",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },

      {
        "<leader>f",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>lG",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Git Branches",
      },
      {
        "<leader>sp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "<C-p>",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },

      {
        "<leader>so",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      {
        "<leader>sm",
        function()
          Snacks.picker.marks()
        end,
        desc = "Marks",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Selection or word",
        mode = { "n", "x" },
      },
      --LSP
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Goto Definition",
      },
      {
        "gD",
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = "Goto Declaration",
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "References",
      },
      {
        "gI",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "Goto Implementation",
      },
      {
        "gy",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "Goto Type Definition",
      },
      {
        "<leader>lG",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostic",
      },
      {
        "<leader>lg",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Diagnostic Buffer",
      },
      {
        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>Z",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Toggle Zoom",
      },
      -- { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer", },
      -- { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer", },
      -- new
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      {
        "<leader>N",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>cR",
        function()
          Snacks.rename.rename_file()
        end,
        desc = "Rename File",
      },
      -- Git
      {
        "<leader>gs",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
        mode = { "n", "v" },
      },

      {
        "<leader>gB",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
        mode = { "n", "v" },
      },
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git Blame Line",
      },
      {
        "<leader>gf",
        function()
          Snacks.lazygit.log_file()
        end,
        desc = "Lazygit Current File History",
      },
      -- { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit", },
      {
        "<leader>gl",
        function()
          Snacks.lazygit.log()
        end,
        desc = "Lazygit Log (cwd)",
      },
      -- { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications", },
      {
        "<c-/>",
        function()
          Snacks.terminal()
        end,
        desc = "Toggle Terminal",
        mode = { "t", "n" },
      },
      {
        "<c-_>",
        function()
          Snacks.terminal()
        end,
        desc = "which_key_ignore",
      },
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.7,
            height = 0.7,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>Us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>Uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>UL")
          Snacks.toggle.diagnostics():map("<leader>Ud")
          Snacks.toggle.line_number():map("<leader>Ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>Uc")
          Snacks.toggle.treesitter():map("<leader>UT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>Ub")
          Snacks.toggle.inlay_hints():map("<leader>Uh")
          Snacks.toggle.indent():map("<leader>Ug")
          Snacks.toggle.dim():map("T")
        end,
      })
    end,
  },
}
