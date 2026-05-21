# Shecho's NVIM config

## Config layout

Active plugin specs live in `lua/user/plugins/` and `lua/user/plugins/lsp/`.

- `lua/user/plugins/`: active plugin specs
- `lua/user/plugins/lsp/`: active LSP and formatting specs
- `archive/plugins/rollback/`: previously active configs kept for quick restore
- `archive/plugins/candidates/`: future experiments not currently enabled
- `archive/plugins/retired/`: replaced configs kept only as reference
- `archive/backups/`: one-off backups removed from the active tree

`lua/user/lazy.lua` only imports the active plugin directories. Nothing under `archive/` is loaded by `lazy.nvim`.

## Default stack

The active setup leans on `snacks.nvim` for most editor surfaces, while keeping `fzf-lua` and `telescope.nvim` available where their workflows are still preferred.

- picker/search: `snacks.nvim`, with `fzf-lua` and `telescope.nvim` kept active
- explorer: `snacks.explorer`
- terminal: `Snacks.terminal`
- formatting: `conform.nvim`
- completion: `blink.cmp`
- LSP UI: native LSP + `trouble.nvim` + `snacks.nvim`

Older alternatives are kept in `archive/` when they are useful for rollback or future experiments.
