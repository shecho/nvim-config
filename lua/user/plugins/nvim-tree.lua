return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- keys = {
  --   "<leader>e",
  --   "<cmd>NvimTreeFindFileToggle<CR>",
  --   desc = "Toggle file explorer",
  -- },
  config = function()
    local nvimtree = require("nvim-tree")
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])
    local icons = require("user.icons")
    local utils = require("nvim-tree.utils")
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")
      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end
      -- default mappings
      api.config.mappings.default_on_attach(bufnr)
      -- custom mappings
      vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
      vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
      vim.keymap.set("n", "U", api.tree.toggle_hidden_filter, opts("Toogle hidden filter?"))
      -- vim.keymap.set("n", "l", api.tree.open.edit, opts("Open"))
    end

    -- configure nvim-tree
    nvimtree.setup({
      respect_buf_cwd = true,
      reload_on_bufenter = true,
      sync_root_with_cwd = true,
      on_attach = my_on_attach,
      sort_by = "case_sensitive",
      update_focused_file = {
        update_cwd = true,
        enable = true,
        update_root = true,
      },
      hijack_directories = { enable = true },
      disable_netrw = true,
      hijack_netrw = true,
      open_on_tab = true,
      update_cwd = true,
      -- open_on_setup = false,
      filters = {
        dotfiles = false,
        -- dotfiles = true,
        -- custom = { ".git" },
        -- exclude = { ".env" },
      },
      git = {
        enable = true,
        -- ignore = true,
        timeout = 500,
      },
      view = {
        -- preserve_window_proportions = true,
        width = 40,
        -- height = 30,
        side = "right",
        -- auto_resize = true,
        number = false,
        relativenumber = false,
        adaptive_size = true,
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = true,
        highlight_opened_files = "none",
        root_folder_modifier = ":t",
        indent_markers = {
          enable = false,
          icons = { corner = "└ ", edge = "│ ", none = "  " },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_open = icons.ui.ArrowOpen,
              arrow_closed = icons.ui.ArrowClosed,
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              deleted = "",
              ignored = "◌",
              renamed = "➜",
              staged = "",
              unmerged = "",
              unstaged = "",
              untracked = "?",
            },
          },
        },
      },
      actions = { open_file = { window_picker = { enable = false } } },
    })
    -- set keymaps
    local keymap = vim.keymap
    -- keymap.set("n", "<leader>E", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle explorer current" })
    --  {desc = "Toggle file explorer on current file"}) -- toggle file explorer on current file
    -- keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>",
    --  {desc = "Collapse file explorer"}) -- collapse file explorer
    -- keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>",
    --  {desc = "Refresh file explorer"}) -- refresh file explorer
  end,
}
