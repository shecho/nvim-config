return {
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- optional
    "neovim/nvim-lspconfig", -- optional
  },
  opts = {
    extension = {
      patterns = {
        javascript = { "cn%(([^)]+)%)" },
        typescript = { "clsx%(([^)]+)%)", 'tv%({["^"]}%)', 'cva%({["^"]}%)' },
        tsx = { "cn%(([^)]+)%)", "clsx%(([^)]+)%)", 'tv%({["^"]}%)', 'cva%({["^"]}%)' },
      },
    },
  }, -- your configuration
}
