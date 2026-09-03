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
  s('license_foot', {
    t {'## LICENSE'}, nl(),
    nl(),
    t {'Copyleft (🄯) ' .. os.date("*t").year }, -- os.date("*t").year == os.date("%Y")
        nl(" " .. (os.getenv("USER") or "YOUR_NAME") .. '. All Rights Reserved.\\'),
    t {'Licensed under the **'}, i(1, 'EUPL-1.2'), t { '**. ' },
        nl("See [the LICENSE](./LICENSE) for details.")
    --[[
    Copyleft (🄯) 2026 LibereCode. All Rights Reserved.\
    Licensed under the **EUPL-1.2**. See [the LICENSE](./LICENSE) for details.
    --]]
  }),
}
