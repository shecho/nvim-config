return {
  {
    "saghen/blink.pairs",
    version = "*", -- (recommended) only required with prebuilt binaries

    -- download prebuilt binaries from github releases
    dependencies = "saghen/blink.download",
    build = "cargo build --release",
    -- OR build from source with nix
    -- build = "nix build .#build-plugin",

    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        -- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
        enabled = true,
        -- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L10
        pairs = {},
      },
      highlights = {
        enabled = true,
        groups = {
          "BlinkPairsOrange",
          "BlinkPairsPurple",
          "BlinkPairsBlue",
        },
        matchparen = {
          enabled = true,
          group = "MatchParen",
        },
      },
      debug = false,
    },
  },
  -- {
  --   "windwp/nvim-autopairs",
  --   event = { "InsertEnter" },
  --   dependencies = {
  --     "hrsh7th/nvim-cmp",
  --   },
  --   opts = function()
  --     -- import nvim-autopairs
  --     local autopairs = require("nvim-autopairs")
  --
  --     return {
  --       check_ts = true,
  --       ts_config = {
  --         lua = { "string" },
  --         javascript = { "template_string" },
  --         java = false,
  --       },
  --     }
  --   end,
  -- },
}
