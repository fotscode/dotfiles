vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
    autocmd FileType markdown setlocal spelllang="es,en,cjk"
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup i3config_ft_detection
    autocmd!
    au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
  augroup end

  augroup _vagrant
    autocmd!
    au BufRead,BufNewFile Vagrantfile set ft=ruby
    au BufRead,BufNewFile vagrantfile set ft=ruby
    au BufRead,BufNewFile vagrantfile* set ft=ruby
  augroup end

  augroup _csv
    autocmd!
    au BufRead,BufNewFile *.csv set ft=rfc_csv
  augroup end

  augroup _latex
    autocmd!
    au BufWritePost *.tex call jobstart(['latexdockercmd.sh',expand('%:p')],{'detach':'true'})
  augroup end
  ]])
-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
    callback = function()
        vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
    end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "typescript", "vue" },
    callback = function()
        vim.cmd([[
      set shiftwidth=2
    ]])
    end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
    pattern = { "AlphaReady" },
    callback = function()
        vim.cmd([[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
    end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.cmd("set formatoptions-=cro")
    end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

local function open_nvim_tree(data)
    local IGNORED_FT = {
        "markdown",
        "alpha",
        "dashboard",
        "startify",

    }

    -- buffer is a real file on the disk
    local real_file = vim.fn.filereadable(data.file) == 1

    -- buffer is a [No Name]
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

    -- &ft
    local filetype = vim.bo[data.buf].ft

    local directory = vim.fn.isdirectory(data.file) == 1
    -- only files please
    if not no_name and not directory then
        return
    end

    -- skip ignored filetypes
    if vim.tbl_contains(IGNORED_FT, filetype) then
        return
    end

    -- open the tree but don't focus it
    require("nvim-tree.api").tree.toggle({ focus = false })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
