# AGENTS.md

**Automated Agent Guidelines for /Users/sergio/.config/nvim**

---

**Overview**
This document is intended for coding agents and automated contributors working in this Neovim configuration repository. Here you'll find:
- Build, lint, and test information
- Code style conventions (imports, formatting, naming, typing, error handling)
- Editor-related best practices
- Usage of automated tooling and AI assistants

---

## 1. Build, Lint, Test Commands

### 1.1 Building
This repository is a Neovim configuration and does not have a "build" process in the typical compiled-language sense. Plugin and runtime code is interpreted by Neovim as Lua.

### 1.2 Linting
**Primary Linter Integration:**
- Uses [nvim-lint](https://github.com/mfussenegger/nvim-lint) when enabled; the previous config is archived at `archive/plugins/rollback/linter.lua`.
- Per-filetype linters:
  - JavaScript/TypeScript/Svelte: `eslint_d`
  - Python: `pylint`
- Triggered automatically on buffer events (open, save, etc.) or with `<leader>L` to lint the current buffer.

**Manual linting:**
```lua
:lua require('lint').try_lint()
```
```key
<leader>L -- Lint current file
```

### 1.3 Formatting
Formatting is handled via [conform.nvim](https://github.com/stevearc/conform.nvim):
- Per-language formatters:
  - JS/TS: `prettier`, `prettierd`
  - CSS/HTML/Markdown/JSON/YAML/etc: `prettier`, `prettierd`
  - Lua: `stylua`
  - Python: `isort`, `black`
- To format the current buffer or selection:
```lua
<leader>lf  -- Map to: conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
```

Auto-format on save (configurable per language) is enabled by default, using the fastest available formatter.

### 1.4 Testing
Tests are intended to be run within Neovim using plugins such as [neotest](https://github.com/nvim-neotest/neotest) or vim-test. There is no language-specific test runner enforced.

#### To run tests (e.g., with neotest):
```lua
-- Run nearest test
:lua require('neotest').run.run()
-- Run current file
:lua require('neotest').run.run(vim.fn.expand('%'))
-- Debug nearest test (if supported by adapter)
:lua require('neotest').run.run({ strategy = 'dap' })
```
Follow conventions for running only the nearest/function scope for isolation.


---

## 2. Code Style Guidelines

### 2.1 Imports and Requires
- Use Lua's `require` at the top of each file, grouping standard libraries and plugin imports separately.
- Avoid cyclic module dependencies.
- Prefer relative paths for project-local modules (e.g., `require('user.plugins.lsp.lspconfig')`).
- Use table-based module returns for plugin and utility modules.

### 2.2 Formatting and Whitespace
- **Formatter:** [stylua](https://github.com/JohnnyMorganz/StyLua)
- **Config:**
    - `indent_type = "Spaces"`
    - `indent_width = 2`
    - `column_width = 180`
    - Requires within file sorted (`sort_requires.enabled = true`)
- **Whitespace:**
    - Always use spaces over tabs (see `expandtab = true` in options.lua).
    - Remove trailing whitespace automatically on save.
    - Indentation managed by `shiftwidth=2`, `tabstop=2` in Lua and Vimscript.

### 2.3 Types and Robustness
- Use Lua 5.1+ features; annotate parameters and return types in comments where feasible.
- Always check return values when using `pcall` or exception-prone functions.
- Use defensive programming: nil/empty checks, especially in utility modules.
- Implement error handling by capturing errors with `pcall` and user notifications, not silent fails.
- Do not use global variables unless specifically intended (set via `vim.g...`).

### 2.4 Naming Conventions
- Use `snake_case` or `camelCase` for function and variable names; be consistent within a module.
- Module/table names should be descriptive and singular (e.g., `options.lua`, `linter.lua`).
- Plugins loaded via lazy.nvim, maintain snake_case across plugin configs.
- Prefix local utility functions with `M.` when returned from a module.

### 2.5 Error Handling and Logging
- Always wrap error-prone operations in `pcall`.
- For any user-facing error, use:
    ```lua
    vim.notify("Error: " .. err, vim.log.levels.ERROR)
    ```
- For warnings/nonfatal issues, use `vim.notify` with appropriate log level.

### 2.6 Comments and Documentation
- Use multiline block comments for module, function docstrings, and complex logic.
- Mark TODO and FIXME with uppercase at the start of comment lines for future reference.
- Reference upstream plugins/integrations where relevant.

### 2.7 Keymaps and Editor Options
- Use `<leader>` and `<localleader>` as defined: spacebar is the global leader, comma is the local leader.
- Mouse and clipboard are enabled by default.
- Set popup and window blends for UI transparency; avoid user confusion for agent-generated windows.
- Always auto sync clipboard with system (option is set).
- Disable line wrapping.
- Highlight on yank (see autocommands.lua).
- Auto restore cursor position, split/window options set for optimal workflow.

### 2.8 File and Directory Structure
- Place all user modules in `lua/user/` and plugin configs under `lua/user/plugins/`.
- Keep `.vim`, `.lua` files, and plugin code clearly separated. No direct code in root except for loader files (init.lua).
- Keep inactive or rollback plugin specs under `archive/plugins/` so `lua/user/plugins/` stays runtime-only.


---

## 3. Integration with Automated Tools & AI

### 3.1 Copilot
- Copilot is present via `copilot.lua` plugin integration.
- Copilot Chat uses models defined in user config and is available in markdown/help buffers.
- No explicit copilot rule file; adhere to all conventions in this AGENTS.md file.

### 3.2 Automated Formatting & Linting
- All contributors and agents MUST autoformat code (stylua or conform.nvim) and run linter before commits.
- No code or config changes should introduce unstylized, syntactically invalid, or linting-error code.

### 3.3 Other Agent-Specific Directives
- Always prefer utility functions (core/functions.lua) for buffer, window, or notification actions over ad hoc code.
- When adding new settings, append to the appropriate user module or plugin config.
- Use existing autocommand/group patterns when extending editor events.

---

## 4. Summary of Key Settings and Automation

* indent_type: Spaces
* indent_width: 2
* tabstop: 2
* column_width: 180
* Remove trailing whitespace on save (autocmd)
* Mouse and clipboard always active
* Lint on write/save and with <leader>L when the archived nvim-lint setup is restored
* Format on demand and save, with Stylua and Conform.nvim
* System clipboard sync (`opt.clipboard = "unnamedplus"`)
* No writing to AGENTS.md or plugin rules files without maintaining all standards above
* No Cursor or Copilot rules files exist (all style must be derived from here)

---

**For further conventions, consult stylua.toml, options.lua, core/autocommands.lua, and the user/plugin configs. This file MUST be updated if the codebase conventions change.**

*Last updated: March 19, 2026*
