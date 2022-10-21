local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

local tabnine_status_ok, _ = pcall(require, "user.tabnine")
if not tabnine_status_ok then
    return
end

local compare = require "cmp.config.compare"

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local icons = require "user.icons"

local kind_icons = icons.kind

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = false, behavior = cmp.ConfirmBehavior.Replace },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = kind_icons[vim_item.kind]
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            if entry.source.name == "cmp_tabnine" then
                vim_item.kind = icons.misc.Robot
                vim_item.kind_hl_group = "CmpItemKindTabnine"
            end
            if entry.source.name == "copilot" then
                vim_item.kind = icons.git.Octoface
                vim_item.kind_hl_group = "CmpItemKindCopilot"
            end
            vim_item.menu = ({
                nvim_lsp = "",
                luasnip = "",
                buffer = "",
                path = "",
                cmp_tabnine = "",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        {
            name = "copilot",
            group_index = 2,
            max_item_count = 3,
            trigger_characters = {
                {
                    ".",
                    ":",
                    "(",
                    "'",
                    '"',
                    "[",
                    ",",
                    "#",
                    "*",
                    "@",
                    "|",
                    "=",
                    "-",
                    "{",
                    "/",
                    "\\",
                    "+",
                    "?",
                    " ",
                    "\t",
                    "\n",
                },
            },
        },
        { name = "cmp_tabnine", group_index = 2 },
        {
            name = "nvim_lsp",
            filter = function(entry, ctx)
                local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                    return true
                end

                if kind == "Text" then
                    return true
                end
            end,
            group_index = 2
        },
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "luasnip", group_index = 2 },
    },
    sorting = {
        comparators = {
            --require('cmp_tabnine.compare'),
            compare.offset,
            compare.exact,
            -- compare.scopes,
            compare.score,
            compare.recently_used,
            compare.locality,
            -- compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
            --require("copilot_cmp.comparators").prioritize,
            --require("copilot_cmp.comparators").score,
        },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        documentation = false,
        completion = {
            border = "rounded",
            winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
        }
    },
    experimental = {
        ghost_text = false,
    },
}
