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
  s('fn', {
    t {'---'}, i(3, 'Comment for function'), nl(),
    t {'---@param '}, f(copy, 2),       t { ' ' }, i(3, 'param_type'), nl(),
    t {'---@return '}, i(4, 'return_type'), t { ' ' }, f(copy, 6), nl(),
    t {'local function '}, i(1, 'fnName'),   t { '(' }, i(2, 'param'), nl(")"),
    t {'\t'}, i(5, 'print("PLACEHOLDER")'), nl(),
    t {'\treturn '}, i(6, "PLACEHOLDER"), nl(),
    nl('end'),
    i(0,''),
    --[[
    ---comment for: fnname
    ---@param param type
    ---@return type return
    local function fnname(param)
      print("placeholder")
      return return
    end
    --]]
  }),
  -- stylua: ignore
  s("vp",{
    t {"vim.print("}, i(1, "vim.lsp.config"), nl(")"),
    --[[
    vim.print(vim.lsp.config)
    --]]
  }),
}
