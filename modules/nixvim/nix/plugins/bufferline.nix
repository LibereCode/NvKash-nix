{ self, inputs, ... }@top:
{

  # flake.homeModules.nixvim_plug_bufferline =
  flake.homeModules.nixvim_plugins =
    { pkgs, ... }@a:
    {
      # see: <https://nix-community.github.io/nixvim/plugins/bufferline/index.html>
      plugins = {

        bufferline = {
          enable = true;

          # settings = {}; # TODO: <https://nix-community.github.io/nixvim/plugins/bufferline/settings/index.html>
        };

      };
    };
}
