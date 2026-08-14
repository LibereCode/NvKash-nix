local ls = require("luasnip")

-- INFO: SNIPPETS
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

--
---args is a table, where 1 is the text in Placeholder 1, 2 the text in placeholder 2,...
---@param args string[]
---@return string
local function copy(args)
    return args[1]
end

ls.add_snippets("lua", { -- NOTE: MY FIRST LuaSnippet !!!
    -- stylua: ignore

    -- TODO: some core and generic flake/module setup-templates
})
