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

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
    return args[1]
end

ls.add_snippets("lua", { -- NOTE: MY FIRST LuaSnippet !!!
	-- stylua: ignore
  s('func_annotate', {
    t { '---@param ' }, f(copy, 2), t { ' ' }, i(3, 'type'), t { '', '' },
    t { 'local function ' }, i(1, 'fnName'), t { '(' }, i(2, 'param'), t { ')', '' },
    t { '\t' }, i(4, 'print("PLACEHOLDER")'), t { '', '' },
    t { 'end' },
    -- -- Looks like:
    -- ---@param param type
    -- local function fnName(param)
    --   print("PLACEHOLDER")
    -- end
  }),
})
 
