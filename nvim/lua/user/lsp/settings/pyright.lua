return {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                typeCheckingMode = "off",
                useLibraryCodeForTypes = true,
                --useLibraryCodeForTypes = false, -- uncomment this if too laggy
                diagnosticMode = 'openFilesOnly',
                -- stub path using packer
                stubPath = vim.fn.stdpath('data') .. '/site/pack/packer/start/python-type-stubs/stubs',
            },
        },
    },
}
