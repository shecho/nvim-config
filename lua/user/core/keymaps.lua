local M = {}

local expectations = {}
local conflicts = {}
local setup_done = false

local function normalize_modes(mode)
  if type(mode) == "table" then
    return mode
  end

  return { mode }
end

local function spec_id(mode, lhs)
  return mode .. "\31" .. lhs
end

local function caller_location(level)
  local info = debug.getinfo(level or 3, "Sl")
  local source = info and info.source or ""

  if source:sub(1, 1) == "@" then
    source = source:sub(2)
  end

  return source ~= "" and source or nil, info and info.currentline or 1
end

local function map_label(map)
  if type(map) ~= "table" or vim.tbl_isempty(map) then
    return "<missing>"
  end

  if map.desc and map.desc ~= "" then
    return map.desc
  end

  if map.rhs and map.rhs ~= "" then
    return map.rhs
  end

  if map.callback then
    return "<lua callback>"
  end

  return "<unknown>"
end

local function register_expectation(mode, lhs, opts, level)
  opts = opts or {}
  local file, line = caller_location(level or 4)

  for _, current_mode in ipairs(normalize_modes(mode)) do
    local id = spec_id(current_mode, lhs)
    local spec = {
      mode = current_mode,
      lhs = lhs,
      desc = opts.desc,
      owner = opts.owner,
      scope = opts.scope or "global",
      file = opts.file or file,
      line = opts.line or line,
    }

    local existing = expectations[id]
    if existing and (existing.desc ~= spec.desc or existing.owner ~= spec.owner) then
      conflicts[id] = { existing = existing, incoming = spec }
    else
      expectations[id] = spec
    end
  end
end

local function qf_item(spec, text)
  return {
    filename = spec.file,
    lnum = spec.line or 1,
    col = 1,
    text = text,
  }
end

function M.expect(mode, lhs, opts)
  register_expectation(mode, lhs, opts, 3)
end

function M.set(mode, lhs, rhs, opts)
  local map_opts = vim.tbl_deep_extend("force", {}, opts or {})

  if map_opts.protected then
    register_expectation(mode, lhs, map_opts, 4)
  end

  map_opts.protected = nil
  map_opts.owner = nil

  return vim.keymap.set(mode, lhs, rhs, map_opts)
end

function M.audit()
  local issues = {}

  for _, conflict in pairs(conflicts) do
    issues[#issues + 1] = qf_item(
      conflict.incoming,
      string.format(
        "protected keymap conflict for %s %s (%s vs %s)",
        conflict.incoming.mode,
        conflict.incoming.lhs,
        conflict.existing.desc or conflict.existing.owner or "first registration",
        conflict.incoming.desc or conflict.incoming.owner or "second registration"
      )
    )
  end

  for _, spec in pairs(expectations) do
    if spec.scope == "buffer" then
      goto continue
    end

    local map = vim.fn.maparg(spec.lhs, spec.mode, false, true)

    if type(map) ~= "table" or vim.tbl_isempty(map) then
      issues[#issues + 1] = qf_item(spec, string.format("missing protected keymap %s %s", spec.mode, spec.lhs))
    elseif spec.desc and map.desc ~= spec.desc then
      issues[#issues + 1] = qf_item(spec, string.format("protected keymap %s %s changed owner (%s -> %s)", spec.mode, spec.lhs, spec.desc, map_label(map)))
    end

    ::continue::
  end

  table.sort(issues, function(left, right)
    if left.filename == right.filename then
      return left.lnum < right.lnum
    end

    return (left.filename or "") < (right.filename or "")
  end)

  return issues
end

function M.audit_buffer(bufnr)
  local issues = {}
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  for _, spec in pairs(expectations) do
    if spec.scope ~= "buffer" then
      goto continue
    end

    local current_buf = vim.api.nvim_get_current_buf()
    if current_buf ~= bufnr then
      vim.api.nvim_set_current_buf(bufnr)
    end
    local map = vim.fn.maparg(spec.lhs, spec.mode, false, true)
    if current_buf ~= bufnr then
      vim.api.nvim_set_current_buf(current_buf)
    end

    if type(map) ~= "table" or vim.tbl_isempty(map) then
      issues[#issues + 1] = qf_item(spec, string.format("missing protected keymap %s %s", spec.mode, spec.lhs))
    elseif spec.desc and map.desc ~= spec.desc then
      issues[#issues + 1] = qf_item(spec, string.format("protected keymap %s %s changed owner (%s -> %s)", spec.mode, spec.lhs, spec.desc, map_label(map)))
    end

    ::continue::
  end

  return issues
end

function M.show_audit(opts)
  opts = opts or {}
  local issues = M.audit()

  if #issues == 0 then
    if opts.notify ~= false then
      vim.notify("Protected keymaps look good", vim.log.levels.INFO, { title = "Keymap Audit" })
    end
    return issues
  end

  vim.fn.setqflist({}, " ", { title = "Keymap Audit", items = issues })

  if opts.open ~= false then
    vim.cmd.copen()
  end

  if opts.notify ~= false then
    vim.notify(string.format("Keymap audit found %d issue(s)", #issues), vim.log.levels.WARN, { title = "Keymap Audit" })
  end

  return issues
end

function M.register_defaults()
  M.expect({ "n", "v", "x" }, "s", { desc = "Escape with s", owner = "core.escape", file = "lua/user/keymaps.lua", line = 99 })
  M.expect({ "n", "v", "x" }, "q", { desc = "Escape with q", owner = "core.escape", file = "lua/user/keymaps.lua", line = 101 })
  M.expect({ "n", "t" }, "<C-/>", { desc = "Terminal", owner = "core.terminal", file = "lua/user/keymaps.lua", line = 90 })
  M.expect("n", "<C-_>", { desc = "Terminal", owner = "core.terminal", file = "lua/user/keymaps.lua", line = 93 })
  M.expect("n", "<C-a>", { desc = "Select All", owner = "core.select_all", file = "lua/user/keymaps.lua", line = 142 })
  M.expect("n", "<Tab>", { desc = "Next Buffer", owner = "bufferline", file = "lua/user/plugins/bufferline.lua", line = 15 })
  M.expect("n", "<S-Tab>", { desc = "Previous Buffer", owner = "bufferline", file = "lua/user/plugins/bufferline.lua", line = 14 })
  M.expect("n", "=", { desc = "Buffers", owner = "flybuf", file = "lua/user/plugins/buffer.lua", line = 27 })
  M.expect({ "n", "x" }, "<leader>ca", { desc = "Ask opencode…", owner = "opencode", file = "lua/user/plugins/opencode.lua", line = 35 })
  M.expect({ "n", "x" }, "<leader>cc", { desc = "Execute opencode action…", owner = "opencode", file = "lua/user/plugins/opencode.lua", line = 38 })
  M.expect("n", "<leader>Sa", { desc = "Select Scratch Buffer", owner = "snacks.scratch", file = "lua/user/plugins/snacks.lua", line = 148 })
  M.expect("n", "gd", { desc = "Definition", owner = "snacks.lsp_definition", file = "lua/user/plugins/snacks.lua", line = 200 })
  M.expect("n", "gr", { desc = "References", owner = "snacks.lsp_references", file = "lua/user/plugins/snacks.lua", line = 204 })
  M.expect("n", "gi", { desc = "Implementation", owner = "snacks.lsp_implementation", file = "lua/user/plugins/snacks.lua", line = 206 })
  M.expect("n", "<leader>Ss", { desc = "Select Session", owner = "session.select", file = "lua/user/plugins/session.lua", line = 10 })
  M.expect("n", "<localleader>p", { desc = "Telescope Projects", owner = "core.projects", file = "lua/user/keymaps.lua", line = 115 })
  M.expect("n", "<localleader>e", { desc = "Explorer", owner = "core.explorer", file = "lua/user/keymaps.lua", line = 117 })
  M.expect("n", "<C-c>", { desc = "Escape and Clear Search", owner = "core.escape_clear", file = "lua/user/keymaps.lua", line = 127 })
end

function M.setup()
  if setup_done then
    return
  end

  setup_done = true
  M.register_defaults()

  vim.api.nvim_create_user_command("KeymapAudit", function()
    M.show_audit({ open = true, notify = true })
  end, { desc = "Audit protected keymaps" })

  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("user_keymap_audit", { clear = true }),
    pattern = "VeryLazy",
    callback = function()
      vim.defer_fn(function()
        local issues = M.audit()
        if #issues > 0 then
          vim.notify(string.format("Keymap audit found %d issue(s). Run :KeymapAudit", #issues), vim.log.levels.WARN, { title = "Keymap Audit" })
        end
      end, 50)
    end,
  })
end

return M
