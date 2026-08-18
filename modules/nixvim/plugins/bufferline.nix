{ self, inputs, ... }@top:
let
  plugin_name = "bufferline";
in
{
  flake.nixvimModules.${plugin_name} =
    { pkgs, ... }@a:
    {
      # see: <https://nix-community.github.io/nixvim/plugins/bufferline/index.html>
      plugins = {
        ${plugin_name} = {
          enable = true;

          # settings = {}; # TODO: <https://nix-community.github.io/nixvim/plugins/bufferline/settings/index.html>
        };

      };
    };
}
