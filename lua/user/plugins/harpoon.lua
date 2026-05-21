return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  config = function()
    local harpoon = require("harpoon")
    local keymap = vim.keymap
    local harpoon_root = vim.uv.cwd() or vim.fn.getcwd()

    local function current_file_item()
      local path = vim.api.nvim_buf_get_name(0)
      local pos = vim.api.nvim_win_get_cursor(0)

      return {
        value = path,
        context = {
          row = pos[1],
          col = pos[2],
        },
      }
    end

    harpoon:setup({
      settings = {
        save_on_toggle = true, -- persist list when quick menu closes
        sync_on_ui_close = true,
        key = function()
          return harpoon_root
        end,
      },
      default = {
        get_root_dir = function()
          return harpoon_root
        end,
        create_list_item = function()
          return current_file_item()
        end,
      },
    })

    -- Load once so Harpoon keeps the disk state in memory for this session.
    harpoon:list()

    -- Add / remove / clear
    keymap.set("n", "<leader>na", function()
      harpoon:list():add()
      harpoon:sync()
    end, { desc = "Mark file with harpoon" })
    keymap.set("n", "<leader>nR", function()
      harpoon:list():remove()
      harpoon:sync()
    end, { desc = "Remove current file from harpoon" })
    keymap.set("n", "<leader>nC", function()
      harpoon:list():clear()
      harpoon:sync()
    end, { desc = "Reset all harpoon marks" })

    -- Navigation
    keymap.set("n", "<leader>nn", function()
      harpoon:list():next()
    end, { desc = "Go to next harpoon mark" })
    keymap.set("n", "<leader>np", function()
      harpoon:list():prev()
    end, { desc = "Go to previous harpoon mark" })

    -- Jump to file by letter (muscle memory)
    keymap.set("n", "<leader>mq", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon file 1" })
    keymap.set("n", "<leader>mw", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon file 2" })
    keymap.set("n", "<leader>me", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon file 3" })
    keymap.set("n", "<leader>mr", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon file 4" })
    keymap.set("n", "<leader>mt", function()
      harpoon:list():select(5)
    end, { desc = "Harpoon file 5" })

    -- Jump to file by number (aliases)
    keymap.set("n", "<leader>n1", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon file 1" })
    keymap.set("n", "<leader>n2", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon file 2" })
    keymap.set("n", "<leader>n3", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon file 3" })
    keymap.set("n", "<leader>n4", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon file 4" })
    keymap.set("n", "<leader>n5", function()
      harpoon:list():select(5)
    end, { desc = "Harpoon file 5" })

    -- Quick menu
    keymap.set("n", "<leader>mm", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Harpoon menu", silent = true, noremap = true })

    -- Snacks picker integration (VS Code quick-open style)
    keymap.set("n", "<leader>MM", function()
      Snacks.picker({
        title = "Harpoon",
        layout = { preset = "vscode", hidden = { "preview" } },
        finder = function()
          local items = {}
          for i, item in ipairs(harpoon:list().items) do
            table.insert(items, {
              text = item.value,
              file = item.value,
              idx = i,
              label = string.format("%d: %s", i, item.value),
            })
          end
          return items
        end,
        format = "file",
        confirm = function(picker, item)
          harpoon:sync()
          picker:close()
          if item then
            harpoon:list():select(item.idx)
          end
        end,
      })
    end, { desc = "Harpoon picker" })
  end,
}
