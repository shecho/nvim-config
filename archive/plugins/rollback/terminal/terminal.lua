return {
  -- {
  --   "voldikss/vim-floaterm",
  --   cmd = { "FloatermToggle", "FloatermNew", "FloatermNext", "FloatermPrev" },
  --   config = function()
  --     vim.cmd([[
  --       " let g:floaterm_wintype='normal'
  --       " let g:floaterm_height=6
  --       let g:floaterm_keymap_toggle = '<Leader>2'
  --       let g:floaterm_keymap_next   = '<F1>'
  --       let g:floaterm_keymap_prev   = '<F3>'
  --       let g:floaterm_keymap_new    = '<F4>'
  --       " Floaterm
  --       let g:floaterm_gitcommit='floaterm'
  --       let g:floaterm_autoinsert=1
  --       let g:floaterm_width=0.95
  --       let g:floaterm_height=0.65
  --       let g:floaterm_wintitle=0
  --       let g:floaterm_autoclose=1
  --       let g:floaterm_position= 'bottomright'
  --     ]])
  --   end,
  -- },
  {
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      opts = {
        open_mapping = [[<c-\>]],
      },
    },
  },
}
