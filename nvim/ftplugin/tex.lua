local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
}

-- jobstart with this callback
-- call jobstart(['latexindent',expand('%:p')],{'detach':'true','on_stdout': 'reload_file' })
-- error reload_file is unknown, and the fix is:
-- call jobstart(['latexindent',expand('%:p')],{'detach':'true','on_stdout': 'lua reload_file()' })

local mappings = {
    { "<leader>L", group = "Latex",                                                                nowait = true,     remap = false },
    { "<leader>Lc", "<cmd>call jobstart(['latexmk',expand('%:p')],{'detach':'true'})<cr>",          desc = "Compile",  nowait = true, remap = false },
    { "<leader>Lo", "<cmd>call jobstart(['sioyek',expand('%:p:r')..'.pdf'],{'detach':'true'})<cr>", desc = "View pdf", nowait = true, remap = false },
    { "<leader>Lf", "<cmd>call jobstart(['latexindent',expand('%:p')],{'detach':'true'})<cr>",      desc = "Format pdf", nowait = true, remap = false },
}

which_key.add(mappings, opts)
