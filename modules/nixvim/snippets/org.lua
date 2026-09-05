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

---Newline with optional `eol` character
---@param eol? string
local function nl(eol)
  return t({ eol or "", "" })
end

-- args is a table, where 1 is the text in Placeholder 1, 2 the text in
-- placeholder 2,...
local function copy(args)
  return args[1]
end

return {
  -- stylua: ignore
  s('codeblock', {
    t {'#+begin_src '}, i(1, 'lua'), t{ ' '}, i(2, ":eval no"), nl(),
    i(3, 'print("Hello World!")'), nl(),
    t {'#+end_src '}, nl(),
    i(0,""),
    --[[
    #+begin_src lua :eval no
    print("Hello World!")
    #+end_src
    --]]
  }),
}
