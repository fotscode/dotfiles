local status_ok, errorlens = pcall(require, "error-lens")
if not status_ok then
    vim.notify("Error lens not installed")
    return
end

errorlens.setup({
    -- this setting tries to auto adjust the colors
    -- based on the diagnostic-highlight groups and your
    -- theme background color with a color blender
    enabled = true,
    auto_adjust = {
        enable = false,
        fallback_bg_color = nil, -- mandatory if enable true (e.g. #281478)
        step = 7,            -- inc: colors should be brighter/darker
        total = 30           -- steps of blender
    },
    prefix = 4,              -- distance code <-> diagnostic message
    -- default colors
    colors = {
        error_fg = "#e06c75", -- diagnostic font color
        error_bg = "#4B252C", -- diagnostic line color
        warn_fg = "#e5c07b",
        warn_bg = "#554400",
        info_fg = "#61afef",
        info_bg = "#00404b",
        hint_fg = "#c678dd",
        hint_bg = "#46285d"
    }
})
