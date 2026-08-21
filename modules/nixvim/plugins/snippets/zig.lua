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

ls.add_snippets("zig", { -- NOTE: MY FIRST LuaSnippet !!!
	-- stylua: ignore
  s('stdMain', {
    t { 'const std = @import("std");' }, t { '', '', '' },
    t { 'const err = error{' }, i(1, 'errName'), t { '};', '', '' },
    t { 'pub fn main(init: std.process.Init) !void {', '' },
    t { '\t' }, i(2, 'std.debug.print("PLACEHOLDER");'), t { '', '' },
    t { '};' },
    -- -- Looks like:
    -- const std = @import("std");
    -- const err = error{errName};
    -- pub fn main(init: std.process.Init) !void {
    --    std.debug.print("PLACEHOLDER");
    -- }
  }),
})
