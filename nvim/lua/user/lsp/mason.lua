local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
    return
end


local servers = {
    "lua_ls",
    "ts_ls",
    "jdtls",
    "pyright",
    "volar",
    "lemminx",
    "texlab",
    "clangd",
    "arduino_language_server",
    "buf_ls",
    "gopls",
    "astro"
}

local settings = {
    ui = {
        border = "rounded",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
    ensure_installed = servers,
    automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }

    if server == "lua_ls" then
        local sumneko_opts = require "user.lsp.settings.sumneko_lua"
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server == "pyright" then
        local pyright_opts = require "user.lsp.settings.pyright"
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server == "vuels" then
        local vuels_opts = require "user.lsp.settings.vuels"
        opts = vim.tbl_deep_extend("force", vuels_opts, opts)
    end

    if server == "marksman" then
        local marksman_opts = require "user.lsp.settings.marksman"
        opts = vim.tbl_deep_extend("force", marksman_opts, opts)
    end

    if server == "texlab" then
        local texlab_opts = require "user.lsp.settings.texlab"
        opts = vim.tbl_deep_extend("force", texlab_opts, opts)
    end

    if server == "arduino_language_server" then
        local arduino_opts = require "user.lsp.settings.arduino"
        opts = vim.tbl_deep_extend("force", arduino_opts, opts)
    end

    if server == "gopls" then
        local gopls_opts = require "user.lsp.settings.gopls"
        opts = vim.tbl_deep_extend("force", gopls_opts, opts)
    end

    if server == "astro" then
        local astro_opts = require "user.lsp.settings.astro"
        opts = vim.tbl_deep_extend("force", astro_opts, opts)
    end

    if server == "jdtls" then goto continue end

    lspconfig[server].setup(opts)
    ::continue::
end
