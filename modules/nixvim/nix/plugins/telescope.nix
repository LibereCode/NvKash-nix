{ self, inputs, ... }@top:
{

  # flake.homeModules.nixvim_plug_telescope =
  flake.homeModules.nixvim_plugins =
    { pkgs, ... }@a:
    {
      plugins = {

        telescope = {
          enable = true;
          # keymaps = {}; # TODO:
          # extensions = {}; # TODO:
          # settings = {}; # TODO:
        };

      };
    };
}
