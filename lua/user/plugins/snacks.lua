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
      -- words = { enabled = true },
      styles = { notification = {}, zen = { width = 0.90, backdrop = { transparent = true, blend = 20 } } },
      explorer = { minimal = true, enabled = true, replace_netrw = true, layout = { position = "right" } },
      zen = { enabled = true, toggles = { dim = false } },
      picker = {
        enabled = true,
        layouts = {
          float_explorer = {
            preview = "main",
            layout = {
              backdrop = false,
              width = 40,
              min_width = 40,
              height = 0,
              position = "right",
              border = "none",
              box = "vertical",
              {
                win = "input",
                height = 1,
                border = "none",
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            },
          },
          default = { layout = { width = 0.95, height = 0.95 } },
          vscode = { layout = { width = 0.60 } },
          dropdown = { layout = { width = 0.75 } },
          telescope = { layout = { width = 0.95, height = 0.95 } },
        },
        -- layout = { layout = { box = "horizontal" } },
        sources = {
          command_history = { focus = "list" },
          explorer = { layout = { layout = { position = "right" }, border = "none" } }, -- explorer = { layout = { preset = "right" } }, --  same as
          recent = { layout = { preset = "vscode" }, focus = "list" },
          buffers = { layout = { preset = "vscode" }, focus = "list" }, -- buffers = { layout = { layout = { width = 0.99, height = 0.99 } } },
          marks = { layout = { preset = "telescope" }, focus = "list" },
          files = { layout = { border = "none", preset = "dropdown", layout = { width = 0.95, height = 0.95 } } }, -- files = { layout = { layout = { width = 0.90, height = 0.90 } } },
          projects = { layout = { preset = "select" }, focus = "list" },
          diagnostics_buffer = { layout = { preset = "select" }, focus = "list" },
          diagnostics = { layout = { preset = "ivy" }, focus = "list" },
          git_diff = { layout = { preset = "ivy" }, focus = "list" },
          lsp_references = { layout = { preset = "ivy" }, focus = "list" },
          lsp_definitions = { layout = { preset = "dropdown" }, focus = "list" },
          -- files = { layout = { preset = "my_vertical_layout" }, focus = "list" }, -- files = { layout = { layout = { width = 0.90, height = 0.90 } } },
        },
      },
      dashboard = {
        enabled = true,
        width = 90,
        -- preset = {
        --   keys = {
        --     { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        --   },
        -- },
        sections = {
          { section = "header" },
          {
            section = "keys",
            gap = 1,
            padding = 1,
            { icon = " ", key = "s", action = ":lua require('persistence').select()", desc = "Restore Session" },
            { icon = "󱄋 ", key = "L", action = ":lua require('persistence').load({ last = true })", desc = "Restore Last Session" },
          },
          {
            pane = 2,
            icon = require("user.icons").kind.File,
            title = "Recent Files",
            limit = 10,
            section = "recent_files",
            indent = 2,
            padding = 1,
            { icon = "車", key = "i", desc = "init.lua", action = ":e $MYVIMRC" },
            { icon = " ", key = "Z", desc = "zshrc", action = ":e ~/.zshrc" },
            { icon = " ", key = "S", desc = "snacks.lua", action = ":e ~/.config/nvim/lua/user/plugins/snacks.lua" },
          },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          -- stylua: ignore
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function() return Snacks.git.get_root() ~= nil end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
          { section = "session" },
        },
      },
    },

    -- stylua: ignore
    keys = {
      -- buffer
      { "<leader>d",  function() Snacks.bufdelete() end,                                                 desc = "Delete buffer", },
      { "<leader>D",  function() Snacks.bufdelete.delete() end,                                          desc = "Delere buffer force", },
      { "<leader>bb", function() Snacks.bufdelete.other() end,                                           desc = "Delete other buffers", },
      { "<leader>bd", function() Snacks.bufdelete() end,                                                 desc = "Delete Buffer", },
      -- search and explorer
      { "<leader>e",  function() Snacks.explorer() end,                                                  desc = "File Explorer", },
      { "<leader>E",  function() Snacks.picker.files({ layout = "float_explorer", focus = 'list' }) end, desc = "File Explorer", },
      { "<leader>p",  function() Snacks.picker.smart() end,                                              desc = "Smart Files", },
      { "<leader>sf", function() Snacks.picker.smart() end,                                              desc = "Smart Files", },
      { "<leader>sb", function() Snacks.picker.buffers() end,                                            desc = "Buffers", },
      { "<leader>sk", function() Snacks.picker.keymaps() end,                                            desc = "Keymaps", },
      { "<leader>sc", function() Snacks.picker.command_history() end,                                    desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end,                                           desc = "Command" },
      { "<leader>sh", function() Snacks.picker.highlights() end,                                         desc = "Highlights", },
      { "<leader>sj", function() Snacks.picker.jumps() end,                                              desc = "Jumps", },
      { "<leader>sH", function() Snacks.picker.search_history() end,                                     desc = "Search History", },
      { "<leader>sd", function() Snacks.picker.files({ layout = "dropdown" }) end,                       desc = "Find Files", },
      { "<leader>f",  function() Snacks.picker.files() end,                                              desc = "Find Files", },
      { "<leader>sG", function() Snacks.picker.git_branches() end,                                       desc = "Git Branches", },
      { "<leader>sp", function() Snacks.picker.projects() end,                                           desc = "Projects", },
      { "<C-p>",      function() Snacks.picker.files({ layout = "vscode" }) end,                         desc = "Files", },
      { "<leader>so", function() Snacks.picker.recent() end,                                             desc = "Recent", },
      { "<leader>sm", function() Snacks.picker.marks() end,                                              desc = "Marks", },
      { "<leader>sg", function() Snacks.picker.grep() end,                                               desc = "Grep", },
      { "<leader>sw", function() Snacks.picker.grep_word() end,                                          desc = "Selection word",       mode = { "n", "x", "v" }, },
      --LSP
      { "gd",         function() Snacks.picker.lsp_definitions() end,                                    desc = "Definition", },
      { "gh",         function() Snacks.picker.lsp_definitions() end,                                    desc = "Definition", },
      { "gD",         function() Snacks.picker.lsp_declarations() end,                                   desc = "Declaration", },
      { "gr",         function() Snacks.picker.lsp_references() end,                                     nowait = true,                 desc = "References", },
      { "<leader>ls", function() Snacks.picker.lsp_references() end,                                     nowait = true,                 desc = "Goto Definition", },
      { "gI",         function() Snacks.picker.lsp_implementations() end,                                desc = "Implementation", },
      { "gi",         function() Snacks.picker.lsp_implementations() end,                                desc = "Implementation", },
      { "<leader>lI", function() Snacks.picker.lsp_implementations() end,                                desc = "Implementation", },
      { "gy",         function() Snacks.picker.lsp_type_definitions() end,                               desc = "Type Definition", },
      { "<leader>lt", function() Snacks.picker.lsp_type_definitions() end,                               desc = "Type Definition", },
      { "<leader>lB", function() Snacks.picker.diagnostics() end,                                        desc = "Diagnostic", },
      { "<leader>lb", function() Snacks.picker.diagnostics_buffer() end,                                 desc = "Diagnostic Buffer", },
      -- Zen
      { "<leader>z",  function() Snacks.zen() end,                                                       desc = "Toggle Zen Mode", },
      { "<leader>Z",  function() Snacks.zen.zoom() end,                                                  desc = "Toggle Zoom", },
      -- News
      { "<leader>Un", function() Snacks.picker.notifications() end,                                      desc = "History", },
      { "<leader>N",  function() Snacks.notifier.show_history() end,                                     desc = "History", },
      { "<leader>cR", function() Snacks.rename.rename_file() end,                                        desc = "Rename File", },
      -- Git
      { "<leader>gB", function() Snacks.gitbrowse() end,                                                 desc = "Git Browse",           mode = { "n", "v" }, },
      { "<leader>gb", function() Snacks.git.blame_line() end,                                            desc = "Git Blame Line", },
      { "<leader>gd", function() Snacks.picker.git_diff() end,                                           desc = "Git diff", },
      { "<leader>gF", function() Snacks.picker.git_log_file() end,                                       desc = "Current File History", },
      { "<leader>gf", function() Snacks.lazygit.log_file() end,                                          desc = "Lazygit File History", },
      { "<leader>gl", function() Snacks.lazygit.log() end,                                               desc = "Lazygit Log (cwd)", },
      { "<c-/>",      function() Snacks.terminal() end,                                                  desc = "Terminal",             mode = { "t", "n" }, },
      { "<c-_>",      function() Snacks.terminal() end,                                                  desc = "Terminal", },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,                                    desc = "Next Reference",       mode = { "n", "t" }, },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end,                                   desc = "Prev Reference",       mode = { "n", "t" }, },

      -- { "<leader>gs", function() Snacks.gitbrowse() end,                           desc = "Git Browse",                   mode = { "n", "v" }, },
      -- { "<leader>gF", function() Snacks.picker.git_log() end,                    desc = "Lazygit Current File History", },
      -- { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer", },
      -- { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer", },
      -- { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications", },
      -- { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit", },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.7,
            height = 0.7,
            wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3, },
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
          -- Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>Ub")
          Snacks.toggle.inlay_hints():map("<leader>Uh")
          Snacks.toggle.indent():map("<leader>Ug")
          Snacks.toggle.dim():map("T")
        end,
      })
    end,
  },
}
