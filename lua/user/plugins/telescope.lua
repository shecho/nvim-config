return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  -- branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "ThePrimeagen/harpoon", event = "VeryLazy" },
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "tsakirist/telescope-lazy.nvim" },
    {
      "ahmedkhalf/project.nvim",
      event = "VeryLazy",
      config = function(_, opts)
        require("project_nvim").setup(opts)
        require("telescope").load_extension("projects")
      end,
    },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      event = "VeryLazy",
    },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-media-files.nvim" },
    -- { "danielvolchek/tailiscope.nvim" }, // just for tailwind prjects
  },
  opts = function()
    local telescope = require("telescope")
    -- local builtin = require("telescope.builtin")
    -- local add_to_trouble = require("trouble.sources.telescope").add
    local actions = require("telescope.actions")
    local icons = require("user.icons")
    local trouble = require("trouble.sources.telescope")

    telescope.load_extension("fzf")
    telescope.load_extension("lazy")
    telescope.load_extension("projects")
    telescope.load_extension("ui-select")
    telescope.load_extension("file_browser")
    telescope.load_extension("harpoon")
    telescope.load_extension("egrepify")
    telescope.load_extension("media_files")
    -- telescope.load_extension("tailiscope")

    local keymap = vim.keymap
    keymap.set("n", "<leader>p", "<cmd>Telescope find_files hidden=true no_ignore=true layout_config={width=0.99,height=0.99}<cr>", { desc = "Fuzzy find files" })
    keymap.set(
      "n",
      "<leader>sf",
      -- "<cmd>Telescope file_browser theme=ivy initial_mode=normal<cr>",
      "<cmd>Telescope file_browser initial_mode=normal theme=ivy<cr>",
      { desc = "Find files" }
    )
    keymap.set(
      "n",
      "<leader>ff",
      "<cmd>Telescope find_files theme=dropdown layout_strategy=vertical layout_config={prompt_position='top',width=0.99,height=0.99,vertical={preview_height=0.50},horizontal={preview_height=0.46}}<cr>",
      { desc = "Fuzzy find files" }
    )
    keymap.set(
      "n",
      "<leader>sb",
      "<cmd>Telescope buffers initial_mode=normal layout_config={width=0.70,height=0.60,prompt_position='top',vertical={preview_height=0.9}}<cr>",
      { desc = "Buffers" }
    )
    keymap.set("n", "<leader>sm", "<cmd>Telescope marks initial_mode=normal<cr>", { desc = "Marks" })
    keymap.set("n", "<leader>so", "<cmd>Telescope oldfiles initial_mode=normal<cr>", { desc = "Recent files" })
    keymap.set("n", "<leader>sa", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<C-p>", "<cmd>Telescope projects theme=dropdown<cr>", { desc = "Projects" })

    return {
      defaults = {
        layout_config = {
          width = 0.99,
          height = 0.99,
          -- prompt_position = "top",
          -- preview_cutoff = 120,
          horizontal = { preview_width = 0.45 },
          vertical = { preview_height = 0.45 },
        },
        path_display = { "truncate " },
        prompt_prefix = icons.ui.Telescope .. " ",
        -- path_display = { "smart" },
        file_ignore_patterns = {
          -- ".git/",
          "target/",
          "docs/",
          "vendor/*",
          "%.lock",
          "__pycache__/*",
          "%.sqlite3",
          "%.ipynb",
          "node_modules/*",
          -- "%.svg",
          "%.otf",
          "%.ttf",
          "%.webp",
          ".dart_tool/",
          ".github/",
          ".gradle/",
          ".idea/",
          ".settings/",
          ".vscode/",
          "__pycache__/",
          "build/",
          -- "env/",
          "gradle/",
          "node_modules/",
          "%.pdb",
          "%.dll",
          "%.class",
          "%.exe",
          "%.cache",
          "%.ico",
          -- "%.pdf",
          "%.dylib",
          "%.jar",
          -- "%.docx",
          "%.met",
          "smalljre_*/*",
          ".vale/",
          "%.burp",
          "%.mp4",
          "%.mkv",
          "%.rar",
          "%.zip",
          "%.7z",
          "%.tar",
          "%.bz2",
          "%.epub",
          "%.flac",
          "%.tar.gz",
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,

            ["<C-j>"] = actions.move_selection_next,
            ["<D-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<D-k>"] = actions.move_selection_previous,
            ["<C-l>"] = actions.select_default,

            ["<C-b>"] = actions.results_scrolling_up,
            ["<C-f>"] = actions.results_scrolling_down,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,
            ["<C-s>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            -- ["<C-t>"] = actions.select_tab,
            ["<c-t>"] = trouble.open_with_trouble,

            ["<c-d>"] = actions.delete_buffer,

            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,
            ["<C-h>"] = actions.which_key, -- keys from pressing <C-h>
            -- ["<esc>"] = actions.close,
          },

          n = {
            ["<c-t>"] = trouble.open,

            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.select_default,
            ["<l>"] = actions.select_default,
            -- ["<C-l>"] = actions.select_default,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<C-b>"] = actions.results_scrolling_up,
            ["<C-f>"] = actions.results_scrolling_down,

            -- ["<Tab>"] = actions.close,
            -- ["<S-Tab>"] = actions.close,
            -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,
            ["q"] = actions.close,
            ["dd"] = actions.delete_buffer,
            ["s"] = actions.select_horizontal,
            ["v"] = actions.select_vertical,
            ["t"] = actions.select_tab,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["?"] = actions.which_key,
          },
        },
      },
      pickers = {
        find_files = {
          -- theme = "dropdown",
          layout_config = {
            width = 0.99,
            height = 0.99,
            prompt_position = "top",
            -- preview_cutoff = 120,
            horizontal = { preview_width = 0.40 },
            vertical = { preview_height = 0.40 },
          },
        },
        lsp_references = {
          -- theme = "dropdown",
          layout_config = {
            width = 0.99,
            height = 0.99,
            -- preview_cutoff = 120,
            horizontal = { preview_width = 0.40 },
            vertical = { preview_height = 0.40 },
          },
        },
        oldfiles = {
          -- theme = "dropdown",
          layout_config = {
            width = 0.99,
            height = 0.99,
            -- preview_cutoff = 120,
            horizontal = { preview_width = 0.40 },
            vertical = { preview_height = 0.40 },
          },
        },
      },
      extensions = {
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = { "png", "webp", "jpg", "jpeg" },
          find_cmd = "rg", -- find command (defaults to `fd`)
        },
        ["ui-select"] = {
          layout_config = { width = 0.5, height = 0.4 },
          on_complete = {
            function()
              vim.cmd("stopinsert")
            end,
          },
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        file_browser = {
          theme = "ivy",
          -- disables netrw and use telescope-file-browser in its place
          -- hijack_netrw = true,
          hijack_netrw = true,
          initial_mode = "normal",
        },
      },
    }
  end,
}
