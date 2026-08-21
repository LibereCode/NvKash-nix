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

ls.add_snippets("sh", { -- 'bash'
	-- stylua: ignore
  s('printf', {
    t { [[printf '\e[]] }, i(1, '32'), t { [[m%s\e[0m\n' "]] },
    i(2, 'Simple colors'), t { '"', '' }
    -- -- Looks like:
    -- printf '\e[32m%s\e[0m\n' "Hello RGB_World!"
  }),
	-- stylua: ignore
  s('printf_rgb', {
    t { [[printf '\e[38;2;]] },
    i(1, 'R'), t { ';' }, i(2, 'G'), t { ';' }, i(3,'B'), t { [[m%s\e[0m\n' "]] },
    i(4, 'Advanced printf colors!'), t { '"', '' }
    -- -- Looks like:
    -- printf '\e[38;2;R;G;Bm%s\e[0m\n' "Hello RGB_World!"
  }),
})
