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
    L = {
        name = "Latex",
        c = { "<Cmd>call jobstart(['latexdockercmd.sh',expand('%:p')],{'detach':'true'})<CR>", "Compile" },
        o = { "<Cmd>call jobstart(['sioyek',expand('%:p:r')..'.pdf'],{'detach':'true'})<CR>", "View pdf" },
        f = {
            "<Cmd>call jobstart(['latexindent',expand('%:p')],{'detach':'true'})<CR>",
            "Format pdf" },
    },
}

which_key.register(mappings, opts)
