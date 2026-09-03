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
  s('module', {
    nl('{ ... }: '),
    nl('let'),
    t {'\tmoduleName = "'}, i(1, 'MODULE_NAME'), nl('";'),
    nl('in'),
    nl('{'),
    t {'\tflake.'}, i(2, "nixosModules"), nl(".${moduleName} ="),
    nl("\t\t{"),
    nl("\t\t\tconfig,"),
    nl("\t\t\tlib,"),
    nl("\t\t\t..."),
    nl("\t\t}:"),
    nl("\t\tlet"),
    nl("\t\t\tenableIf = lib.mkIf config.my.modules.${moduleName}.enable;"),
    nl("\t\tin"),
    nl("\t\t{"),
    nl("\t\t\tconfig = enableIf {"),
    t {'\t\t\t\tprograms.'}, f(copy,1), nl(' = {'),
    nl("\t\t\t\t\tenable = true;"),
    t {"\t\t\t\t\t"}, i(0, "#TODO: add config here;"), nl(),
    nl("\t\t\t\t};"),
    nl("\t\t\t};"),
    nl("\t\t};"),
    nl("}"),
    --[[
    ```nix
    { ... }:
    let
      moduleName = "MODULE_NAME";
    in
    {
      flake.nixosModules.${moduleName} = 
      {
        config,
        lib,
        ...
      }:
      let
        enableIf lib.mkIf config.my.modules.${moduleName}.enable;
      in
      {
        config = enableIf {
        };
      };
    }
    ```
    --]]
  }),
}
