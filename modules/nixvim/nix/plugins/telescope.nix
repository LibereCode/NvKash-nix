{ self, inputs, ... }@top:
let
  plugin_name = "telescope";
in
{
  flake.nixvimModules.${plugin_name} =
    { pkgs, lib, ... }@a:
    let
      inherit (lib.nixvim) mkraw;
    in
    {
      plugins = {
        ${plugin_name} = {
          enable = true;
          # keymaps = {}; # TODO:
          # extensions = {}; # TODO:
          # settings = {}; # TODO:
        };

      };
    };
}
