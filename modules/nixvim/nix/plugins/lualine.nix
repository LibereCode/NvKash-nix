{ self, inputs, ... }@top:
{
  # flake.homeModules.nixvim_plug_lualine =
  flake.homeModules.nixvim_plugins =
    { pkgs, ... }@a:
    {
      # see: <https://nix-community.github.io/nixvim/plugins/lualine/index.html>
      plugins = {

        lualine = {
          enable = true;

          # settings = {}; # TODO: <https://nix-community.github.io/nixvim/plugins/lualine/settings/index.html>
        };

      };
    };
}
