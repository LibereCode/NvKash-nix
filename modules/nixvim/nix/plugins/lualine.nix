{ self, inputs, ... }@top:
let
  plugin_name = "lualine";
in
{
  flake.nixvimmodules.${plugin_name} =
    { pkgs, lib, ... }@a:
    let
      inherit (lib.nixvim) mkraw;
    in
    {
      # see: <https://nix-community.github.io/nixvim/plugins/lualine/index.html>
      plugins = {
        ${plugin_name} = {
          enable = true;

          # settings = {}; # TODO: <https://nix-community.github.io/nixvim/plugins/lualine/settings/index.html>
        };
      };
    };
}
