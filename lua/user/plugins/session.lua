return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- this will only start session saving when an actual file was opened
  opts = {
    -- add any custom options here
  },
  -- stylua: ignore
  keys = {
    { "<leader>Sl", function() require("persistence").load() end,                desc = "Load session", },
    { "<leader>Ss", function() require("persistence").select() end,              desc = "Select  session", },
    { "<localleader>ss", function() require("persistence").select() end,              desc = "Select  session", },
    { "<leader>SL", function() require("persistence").load({ last = true }) end, desc = "Select last session", },
    { "<leader>Sq", function() require("persistence").stop() end,                desc = "Stop", },
  },
}
