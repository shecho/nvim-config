return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        panel = { enabled = false },
        -- enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          -- accept = "<c-j>",
          accept = "<D-l>",
          -- accept = "<CR>",
          accept_line = "<D-CR>",
          accept_word = false,
          -- accept_word = true,
          -- accept_line = true,
          -- next = "<c-p>",
          -- prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
      filetypes = { markdown = true, help = true },
      server_opts_overrides = {
        -- trace = "verbose",
        settings = {
          advanced = {
            -- listCount = 10, -- #completions for panel
            inlineSuggestCount = 3, -- #completions for getCompletions
          },
        },
      },
    },
  },
  -- {
  --
  --   {
  --     "CopilotC-Nvim/CopilotChat.nvim",
  --     branch = "main",
  --     cmd = "CopilotChat",
  --     dependencies = {
  --       { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  --     },
  --     build = "make tiktoken", -- Only on MacOS or Linux
  --     opts = function()
  --       local user = vim.env.USER or "User"
  --       user = user:sub(1, 1):upper() .. user:sub(2)
  --       return {
  --         -- model = "gpt-4.1",
  --         model = "claude-sonnet-4.5",
  --         -- answer_header = "󱗞 ",
  --         question_header = "  " .. user .. " ",
  --         answer_header = "  Copilot ",
  --         debug = false,
  --         -- See Configuration section for rest
  --         window = {
  --           width = 0.4,
  --           -- height = 0.5,
  --         },
  --       }
  --     end,
  --     keys = {
  --       {
  --         mode = { "i", "n", "v" },
  --         "<C-s>",
  --         "<CR>",
  --         ft = "copilot-chat",
  --         desc = "Submit Prompt",
  --       },
  --       -- { "<leader>ct", "<cmd>CopilotChatToggle<cr>", nowait = true, desc = "Toggle copilot chat" },
  --       -- { "<leader>cc", "<cmd>CopilotChatToggle<cr>", nowait = true, desc = "Toggle copilot chat" },
  --       -- stylua: ignore
  --       -- { "<leader>cc", function() return require("CopilotChat").toggle() end, desc = "Toggle CopilotChat",         mode = { "n", "v" }, },
  --       -- stylua: ignore
  --       -- { "<leader>cx", function() return require("CopilotChat").reset() end,  desc = "Clear CopilotChat",          mode = { "n", "v" }, },
  --       -- stylua: ignore
  --       -- { "<leader>cp", function() require("CopilotChat").select_prompt() end, desc = "Prompt Actions CopilotChat", mode = { "n", "v" }, },
  --       -- {
  --       --   "<leader>aq",
  --       --   function()
  --       --     vim.ui.input({ prompt = "Quick Chat: " }, function(input)
  --       --       if input ~= "" then
  --       --         require("CopilotChat").ask(input)
  --       --       end
  --       --     end)
  --       --   end,
  --       --   desc = "Quick Chat (CopilotChat)",
  --       --   mode = { "n", "v" },
  --       -- },
  --     },
  --     config = function(_, opts)
  --       local chat = require("CopilotChat")
  --       vim.api.nvim_create_autocmd("BufEnter", {
  --         pattern = "copilot-chat",
  --         callback = function()
  --           vim.opt_local.relativenumber = false
  --           vim.opt_local.number = false
  --         end,
  --       })
  --
  --       chat.setup(opts)
  --     end,
  --   },
  -- },
}
