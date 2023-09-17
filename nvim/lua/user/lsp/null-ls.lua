local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        null_ls.builtins.formatting.ocamlformat,
        formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.stylua,
        -- diagnostics.flake8
        diagnostics.shellcheck,
        formatting.astyle.with({
            extra_args = {
                "--style=java",
                "--indent=spaces=2",
                "--indent-switches",
                "--indent-col1-comments",
                "--pad-oper",
                "--pad-header",
                "--align-pointer=name",
                "--align-reference=name",
                "--convert-tabs",
                "--close-templates",
                "--max-code-length=120",
                "--break-after-logical",
            },
        }),
    },
})
