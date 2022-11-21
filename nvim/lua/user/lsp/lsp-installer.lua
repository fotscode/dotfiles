local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

local servers = {
    "sumneko_lua",
    "tsserver",
    "jdtls",
    "pyright",
    "vuels",
    "marksman",
    "lemminx",
    "texlab"
}

lsp_installer.setup()

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

    if server == "sumneko_lua" then
        local sumneko_opts = require "user.lsp.settings.sumneko_lua"
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server == "pyright" then
        local pyright_opts = require "user.lsp.settings.pyright"
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server=="vuels" then
        local vuels_opts = require "user.lsp.settings.vuels"
        opts = vim.tbl_deep_extend("force", vuels_opts, opts)
    end

    if server=="marksman" then
        local marksman_opts = require "user.lsp.settings.marksman"
        opts = vim.tbl_deep_extend("force", marksman_opts, opts)
    end

    if server=="texlab" then
        local texlab_opts = require "user.lsp.settings.texlab"
        opts = vim.tbl_deep_extend("force", texlab_opts, opts)
    end

    if server == "jdtls" then goto continue end

    lspconfig[server].setup(opts)
    ::continue::
end
