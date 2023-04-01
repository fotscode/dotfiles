local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
  vim.notify("Copilot not installed")
  return
end

copilot.setup{
  panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 75,
    keymap = {
     accept = "<M-l>",
     next = "<M-]>",
     prev = "<M-[>",
     dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
  server_opts_overrides = {},
}
