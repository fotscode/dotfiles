local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
  vim.notify("Copilot not installed")
  return
end
copilot.setup {
  cmp = {
    enabled = true,
    method = "getCompletionsCycling",
  },
  panel = { -- no config options yet
    enabled = true,
  },
  ft_disable = { "markdown" },
  -- plugin_manager_path = vim.fn.stdpath "data" .. "/site/pack/packer",
  server_opts_overrides = {
    -- trace = "verbose",
    settings = {
      advanced = {
        -- listCount = 10, -- #completions for panel
        inlineSuggestCount = 3, -- #completions for getCompletions
      },
    },
  },
}
vim.g.copilot_node_command = "~/.nvm/versions/node/v17.5.0/bin/node"
