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

ls.add_snippets("all", {
    s("testHello", { t("Hello, "), i(1, "world?"), t("!") }),
    -- cool!
    s("testFn", {
        -- Simple static text.
        t("//Parameters: "),
        -- function, first parameter is the function, second the Placeholders
        -- whose text it gets as input.
        f(copy, 2),
        t({ "", "function " }),
        -- Placeholder/Insert.
        i(1),
        t("("),
        -- Placeholder with initial text.
        i(2, "int foo"),
        -- Linebreak (each item in t(item) give a newline between, and then \t(tab) the 2nd)
        t({ ") {", "\t" }),
        -- i(0), -- Last Placeholder, exit Point of the snippet. (else it just newlines)
        i(3),
        t({ "", "}" }),
        -- -- Looks like:
        -- //Parameters: [copy_of_[i2]]
        -- function [i1] ( [i2] ) {
        --  	[i3]
        --  }
    }),
})
