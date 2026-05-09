return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "VeryLazy",
  config = function()
    local harpoon = require("harpoon")
    local keymap = vim.keymap

    harpoon:setup({
      settings = {
        save_on_toggle = true, -- persist list when quick menu closes
        sync_on_ui_close = true,
      },
    })

    -- Eagerly load the list so harpoon's in-memory state is populated from
    -- disk immediately. Without this, harpoon:sync() on VimLeavePre iterates
    -- an empty self.lists and overwrites the saved JSON with nothing.
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
    keymap.set("n", "<leader>nq", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon file 1" })
    keymap.set("n", "<leader>nw", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon file 2" })
    keymap.set("n", "<leader>ne", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon file 3" })
    keymap.set("n", "<leader>nr", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon file 4" })
    keymap.set("n", "<leader>nt", function()
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

    -- Persist list on Neovim exit
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        harpoon:sync()
      end,
      desc = "Save harpoon list on exit",
    })

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
