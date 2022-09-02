local status_ok, onedark = pcall(require, "onedark")
if not status_ok then
  vim.notify("onedark not installed")
  return
end

local setup = {
  functionStyle = "italic",
  sidebars = {"qf", "vista_kind", "terminal", "packer"},
}

onedark.setup(setup)
