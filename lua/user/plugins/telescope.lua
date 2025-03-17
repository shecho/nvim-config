return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  -- branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "ahmedkhalf/project.nvim",
      event = "VeryLazy",
      config = function(_, opts)
        require("project_nvim").setup(opts)
      end,
    },

    -- { "ThePrimeagen/harpoon", event = "VeryLazy" },
    -- { "nvim-telescope/telescope-file-browser.nvim" },
    -- { "nvim-telescope/telescope-ui-select.nvim", event = "VeryLazy" },
    -- { "nvim-telescope/telescope-media-files.nvim" },
    -- { "danielvolchek/tailiscope.nvim" },
  },
  opts = function()
    local telescope = require("telescope")
    -- local builtin = require("telescope.builtin")
    -- local add_to_trouble = require("trouble.sources.telescope").add
    -- local trouble = require("trouble.sources.telescope")

    local actions = require("telescope.actions")
    local icons = require("user.icons")

    telescope.load_extension("fzf")
    telescope.load_extension("projects")
    -- telescope.load_extension("egrepify")

    -- telescope.load_extension("harpoon")
    -- telescope.load_extension("ui-select")
    -- telescope.load_extension("file_browser")
    -- telescope.load_extension("media_files")
    -- telescope.load_extension("tailiscope")
    local keymap = vim.keymap
    -- keymap.set(
    --   "n",
    --   "<leader>fd",
    --   "<cmd>Telescope find_files theme=dropdown layout_strategy=vertical layout_config={prompt_position='top',width=0.99,height=0.99,vertical={preview_height=0.50},horizontal={preview_height=0.46}}<cr>",
    --   { desc = "find files" }
    -- )
    -- keymap.set("n", "<leader>p", "<cmd>Telescope find_files hidden=true no_ignore=true layout_config={width=0.99,height=0.99}<cr>", { desc = "Fuzzy find files" })
    -- keymap.set("n", "<leader>sf", "<cmd>Telescope file_browser initial_mode=normal theme=ivy<cr>", { desc = "Find files" })
    -- keymap.set("n", "<leader>sb", "<cmd>Telescope buffers initial_mode=normal<cr>", { desc = "Buffers" })
    -- keymap.set("n", "<leader>sm", "<cmd>Telescope marks initial_mode=normal<cr>", { desc = "Marks" })
    -- keymap.set("n", "<leader>so", "<cmd>Telescope oldfiles initial_mode=normal<cr>", { desc = "Recent files" })
    -- keymap.set("n", "<leader>sa", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    -- keymap.set("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>sP", "<cmd>Telescope projects theme=dropdown initial_mode=normal <cr>", { desc = "Projects" })

    return {
      defaults = {
        layout_config = {
          -- prompt_position = "top",
          -- preview_cutoff = 120,
          width = 0.99,
          height = 0.99,
          horizontal = { preview_width = 0.45 },
          vertical = { preview_height = 0.45 },
        },
        path_display = { "truncate " },
        prompt_prefix = icons.ui.Telescope .. " ",
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
          "gradle/",
          "node_modules/",
          "%.pdb",
          "%.dll",
          "%.class",
          "%.exe",
          "%.cache",
          "%.ico",
          "%.dylib",
          "%.jar",
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

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,
            ["<C-s>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            -- ["<C-t>"] = actions.select_tab,
            -- ["<c-t>"] = trouble.open_with_trouble,

            ["<c-d>"] = actions.delete_buffer,

            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,
            ["<C-h>"] = actions.which_key,
            -- ["<esc>"] = actions.close,
          },

          n = {
            -- ["<c-t>"] = trouble.open,
            ["<esc>"] = actions.close,
            ["<C-j>"] = actions.select_default,
            ["<l>"] = actions.select_default,
            ["<CR>"] = actions.select_default,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<C-b>"] = actions.results_scrolling_up,
            ["<C-f>"] = actions.results_scrolling_down,

            ["<C-l>"] = actions.select_default,
            -- ["<Tab>"] = actions.close,
            -- ["<S-Tab>"] = actions.close,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
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
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    }
  end,
}
