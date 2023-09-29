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

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
--vim.wo.colorcolumn = "99999"

--local highlight = {
--    "RainbowRed",
--    "RainbowYellow",
--    "RainbowBlue",
--    "RainbowOrange",
--    "RainbowGreen",
--    "RainbowViolet",
--    "RainbowCyan",
--}
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
--hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
--    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
--    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
--    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
--    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
--    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
--    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
--end)
vim.wo.colorcolumn = "99999"

indent_blankline.setup({
--    indent = {
--        char = "▏",
--        --highlight = highlight
--    },
--    whitespace = {
--        highlight = { "Function", "Label" },
--    },
--    exclude = {
--        filetypes = {
--            "help",
--            "startify",
--            "dashboard",
--            "packer",
--            "neogitstatus",
--            "NvimTree",
--            "Trouble",
--        },
--        buftypes = {
--            "terminal",
--            "nofile"
--        },
--    },
--    include = {
--        node_type = {
--            "abstract_class_declaration", "abstract_method_signature",
--            "accessibility_modifier", "ambient_declaration", "arguments", "array",
--            "array_pattern", "array_type", "arrow_function", "as_expression",
--            "asserts", "assignment_expression", "assignment_pattern",
--            "augmented_assignment_expression", "await_expression",
--            "binary_expression", "break_statement", "call_expression",
--            "call_signature", "catch_clause", "class", "class_body",
--            "class_declaration", "class_heritage", "computed_property_name",
--            "conditional_type", "constraint", "construct_signature",
--            "constructor_type", "continue_statement", "debugger_statement",
--            "declaration", "decorator", "default_type", "do_statement",
--            "else_clause", "empty_statement", "enum_assignment", "enum_body",
--            "enum_declaration", "existential_type", "export_clause",
--            "export_specifier", "export_statement", "expression",
--            "expression_statement", "extends_clause", "finally_clause",
--            "flow_maybe_type", "for_in_statement", "for_statement",
--            "formal_parameters", "function", "function_declaration",
--            "function_signature", "function_type", "generator_function",
--            "generator_function_declaration", "generic_type", "if_statement",
--            "implements_clause", "import", "import_alias", "import_clause",
--            "import_require_clause", "import_specifier", "import_statement",
--            "index_signature", "index_type_query", "infer_type",
--            "interface_declaration", "internal_module", "intersection_type",
--            "jsx_attribute", "jsx_closing_element", "jsx_element", "jsx_expression",
--            "jsx_fragment", "jsx_namespace_name", "jsx_opening_element",
--            "jsx_self_closing_element", "labeled_statement", "lexical_declaration",
--            "literal_type", "lookup_type", "mapped_type_clause",
--            "member_expression", "meta_property", "method_definition",
--            "method_signature", "module", "named_imports", "namespace_import",
--            "nested_identifier", "nested_type_identifier", "new_expression",
--            "non_null_expression", "object", "object_assignment_pattern",
--            "object_pattern", "object_type", "omitting_type_annotation",
--            "opting_type_annotation", "optional_parameter", "optional_type", "pair",
--            "pair_pattern", "parenthesized_expression", "parenthesized_type",
--            "pattern", "predefined_type", "primary_expression", "program",
--            "property_signature", "public_field_definition", "readonly_type",
--            "regex", "required_parameter", "rest_pattern", "rest_type",
--            "return_statement", "sequence_expression", "spread_element",
--            "statement", "statement_block", "string", "subscript_expression",
--            "switch_body", "switch_case", "switch_default", "switch_statement",
--            "template_string", "template_substitution", "ternary_expression",
--            "throw_statement", "try_statement", "tuple_type",
--            "type_alias_declaration", "type_annotation", "type_arguments",
--            "type_parameter", "type_parameters", "type_predicate",
--            "type_predicate_annotation", "type_query", "unary_expression",
--            "union_type", "update_expression", "variable_declaration",
--            "variable_declarator", "while_statement", "with_statement",
--            "yield_expression", "return", "method", "^if", "^while", "^for", "^object",
--            "^table", "block", "arguments", "operation_type"
--        }
--    }
})
hooks.register(hooks.type.HIGHLIGHT_SETUP, hooks.builtin.scope_highlight_from_extmark)
