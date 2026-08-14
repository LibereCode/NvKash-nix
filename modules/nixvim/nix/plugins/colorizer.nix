{ self, inputs, ... }@top:
let
  plugin_name = "colorizer";
in
{
  flake.nixvimModules.${plugin_name} =
    { pkgs, ... }@a:
    {
      plugins = {
        ${plugin_name} = {
          enable = true;
          # settings = {}; # TODO:
        };

      };
    };
}
