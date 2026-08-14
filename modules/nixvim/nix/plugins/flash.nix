{ self, inputs, ... }@top:
let
  plugin_name = "flash";
in
{
  flake.nixvimmodules.${plugin_name} =
    { pkgs, lib, ... }@a:
    let
      inherit (lib.nixvim) mkraw;
    in
    {
      plugins = {
        ${plugin_name} = {
          enable = true;

          settings = {
            # TODO:
            # - rainbow (only) during flash.treesitter* ?
          };

          luaConfig.post =
            # lua
            ''
              local flash = require("flash")
              vim.keymap.set({"n", "x", "o"}, "s", function() flash.jump()              end, { desc = "Flash" })
              vim.keymap.set({"n", "x", "o"}, "S", function() flash.treesitter()        end, { desc = "Flash Treesitter" })
              vim.keymap.set({"o"},           "r", function() flash.remote()            end, { desc = "Flash Remote" })
              vim.keymap.set({"o", "x"},      "R", function() flash.treesitter_search() end, { desc = "Flash Search" })
              vim.keymap.set({"c"},       "<C-s>", function() flash.toggle()            end, { desc = "Toggle Flash Search" })
            '';
        };
      };
    };
}
