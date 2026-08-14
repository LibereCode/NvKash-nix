{ self, inputs, ... }@top:
{

  # flake.homeModules.nixvim_plug_colorizer =
  flake.homeModules.nixvim_plugins =
    { pkgs, ... }@a:
    {
      plugins = {

        colorizer = {
          enable = true;
          # settings = {}; # TODO:
        };

      };
    };
}
