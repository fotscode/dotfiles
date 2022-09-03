local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
  vim.notify("Copilot not installed")
  return
end
copilot.setup {
  cmp = {
    enabled = true,
    method = "getCompletionsCycling",
  }
}
vim.g.copilot_node_command = "~/.nvm/versions/node/v17.5.0/bin/node"
