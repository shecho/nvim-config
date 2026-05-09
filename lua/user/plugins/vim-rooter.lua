return {
  "airblade/vim-rooter",
  event = "VeryLazy",
  config = function()
    if vim.fn.has("wsl") == 1 then
      vim.g.rooter_targets = { "!/mnt/*", "/", "*" }
    end

    vim.g.rooter_change_directory_for_non_project_files = "current"
    vim.g.rooter_silent_chdir = 1
  end,
}
