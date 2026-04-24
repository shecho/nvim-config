# Archived plugin specs

This directory stores plugin specs that are intentionally kept out of the active `lazy.nvim` imports.

- `rollback/`: previously active configs kept around for quick restore.
- `candidates/`: plugins worth revisiting later, but not currently enabled.
- `retired/`: older or replaced configs kept only as reference before deletion.

Rollback specs may be grouped by area, such as `rollback/search/`, `rollback/navigation/`, or `rollback/terminal/`, when a full active workflow was replaced.

Nothing in `archive/plugins/` is loaded by `lua/user/lazy.lua`.
