{ self, inputs, ... }@top:
let
  plugin_name = "dial";
in
{
  flake.nixvimModules.${plugin_name} =
    { pkgs, lib, ... }@a:
    let
      inherit (lib.nixvim) mkRaw;
    in
    {
      plugins = {
        ${plugin_name} = {
          enable = true;

          # Docs: <https://github.com/monaqa/dial.nvim>
          luaConfig.post = # lua
            ''
              local dialpulate = require("dial.map").manipulate
              vim.keymap.set("n", "<C-a>", function() dialpulate("increment", "normal") end,
                { desc = "dial [a]dd", silent = true })
              vim.keymap.set("n", "<C-x>", function() dialpulate("decrement", "normal") end,
                { desc = "dial sub[x]act", silent = true })
              vim.keymap.set("n", "g<C-a>", function() dialpulate("increment", "gnormal") end,
                { desc = "gdial [a]dd", silent = true })
              vim.keymap.set("n", "g<C-x>", function() dialpulate("decrement", "gnormal") end,
                { desc = "gdial sub[x]act", silent = true })

              local augend = require("dial.augend")

              local logical_alias = augend.constant.new({
                elements = { "&&", "||" },
                word = false,
                cyclic = true,
              })

              local ordinal_numbers = augend.constant.new({
                elements = {
                  "first",
                  "second",
                  "third",
                  "fourth",
                  "fifth",
                  "sixth",
                  "seventh",
                  "eight",
                  "ninth",
                  "tenth",
                  "eleventh",
                  "twelth",
                },
                word = false,
                cyclic = true,
              })

              local months = augend.constant.new({
                elements = {
                  "January",
                  "February",
                  "March",
                  "April",
                  "May",
                  "June",
                  "July",
                  "August",
                  "September",
                  "October",
                  "November",
                  "December",
                },
                word = true,
                cyclic = true,
              })

              vim.g.dials_by_ft = {
                css = "css",
                vue = "vue",
                javascript = "typescript",
                typescript = "typescript",
                javascriptreact = "typescript",
                typescriptreact = "typescript",
                json = "json",
                lua = "lua",
                markdown = "markdown",
                sass = "css",
                scss = "css",
                python = "python",
              }
              local dialgroups = {
                default = {
                  augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
                  augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
                  augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                  -- augend.date.alias['%Y/%m/%d'], -- date (2022/02/19, etc.)  -- HACK: 2001-09-11
                  augend.date.alias['%Y-%m-%d'],
                  augend.constant.alias.en_weekday, -- Mon, Tue, ..., Sat, Sun
                  augend.constant.alias.en_weekday_full, -- Monday, Tuesday, ..., Saturday, Sunday
                  ordinal_numbers,
                  months,
                  augend.constant.alias.bool, -- boolean value (true <-> false)
                  augend.constant.alias.Bool, -- boolean value (True <-> False)
                  logical_alias,
                },
                vue = {
                  augend.constant.new { elements = { 'let', 'const' } },
                  augend.hexcolor.new { case = 'lower' },
                  augend.hexcolor.new { case = 'upper' },
                },
                typescript = {
                  augend.constant.new { elements = { 'let', 'const' } },
                },
                css = {
                  augend.hexcolor.new {
                    case = 'lower',
                  },
                  augend.hexcolor.new {
                    case = 'upper',
                  },
                },
                markdown = {
                  augend.constant.new {
                    elements = { '[ ]', '[x]' },
                    word = false,
                    cyclic = true,
                  },
                  augend.misc.alias.markdown_header,
                },
                json = {
                  augend.semver.alias.semver, -- versioning (v1.1.2)
                },
                lua = {
                  augend.constant.new {
                    elements = { 'and', 'or' },
                    word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                    cyclic = true, -- "or" is incremented into "and".
                  },
                },
                python = {
                  augend.constant.new {
                    elements = { 'and', 'or' },
                  },
                },
              }
              for name, group in pairs(dialgroups) do
                if name ~= 'default' then
                  vim.list_extend(group, dialgroups.default)
                end
              end
              require("dial.config").augends:register_group(dialgroups)
            '';
        };
      };
    };
}
