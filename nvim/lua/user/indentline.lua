local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
    vim.notify("Indent line not installed")
    return
end

local status_hook, hooks = pcall(require, "ibl.hooks")
if not status_hook then
    vim.notify("ibl hooks not working")
    return
end

vim.wo.colorcolumn = "99999"

indent_blankline.setup({
    indent = { char = "▏" },
})
hooks.register(hooks.type.HIGHLIGHT_SETUP, hooks.builtin.scope_highlight_from_extmark)
