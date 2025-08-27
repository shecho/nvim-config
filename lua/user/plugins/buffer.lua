return {
  -- {
  --   "echasnovski/mini.bufremove",
  --   opts = {
  --     force = false,
  --   },
  --   keys = {
  --     {
  --       "<leader>DD",
  --       function()
  --         require("mini.bufremove").delete(0, true)
  --       end,
  --       desc = "Delete Buffer (Force)",
  --     },
  --     {
  --       "<leader>Q",
  --       function()
  --         require("mini.bufremove").delete(0, true)
  --       end,
  --       desc = "Delete Buffer (Force)",
  --     },
  --   },
  -- },
  {
    "glepnir/flybuf.nvim",
    cmd = "FlyBuf",
    keys = { { "=", "<cmd>FlyBuf<cr>", nowait = true, desc = "Buffers" } },
    opts = {},
  },
}
