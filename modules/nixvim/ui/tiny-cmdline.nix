{ ... }:
let
  plugin_name = "tiny-cmdline";
in
{
  flake.nixvimModules.${plugin_name} =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      config = {
        extraPlugins = with pkgs.vimPlugins; [ tiny-cmdline-nvim ];
        extraConfigLuaList = [
          # lua
          ''
            ---NOTE [tiny-cmdline.nvim](https://github.com/rachartier/tiny-cmdline.nvim)
            do
              local tcl = require("tiny-cmdline")
              tcl.setup({
                  ---Default config: <https://github.com/rachartier/tiny-cmdline.nvim#configuration>
                  width = {
                      value = "60%",  -- "N%" = fraction of editor columns, integer = absolute columns
                      min = 40,       -- minimum width in columns
                      max = 80,       -- maximum width in columns
                  },

                  -- Window position ("N%" = fraction of available space, integer = absolute columns/rows)
                  position = {
                      x = "50%",  -- horizontal: "0%" = left, "50%" = center, "100%" = right
                      y = "50%",  -- vertical:   "0%" = top,  "50%" = center, "100%" = bottom
                  },

                  -- border = "shadow", -- I... AM... _A.T.O.M.I.C_
                  border = "double",

                  menu_col_offset = 3,

                  title = {
                    enabled = true, -- false,
                    pos = "center",
                  },

                  native_types = { "/", "?" },

                  ${lib.optionalString config.plugins.blink-cmp.enable /* lua */ ''
                    ---`lib.optionalString config.plugins.blink-cmp.enable`
                    on_reposition = tcl.adapters.blink
                  ''}
              })

              vim.o.cmdheight = 0
            end
          ''
        ];
      };
    };
}
