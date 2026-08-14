{ self, inputs, ... }@top:
{

  # flake.homeModules.nixvim_plug_dap =
  flake.homeModules.nixvim_plugins =
    { pkgs, ... }@a:
    {
      plugins = {

        dap = {
          enable = true;
          # adapters = {}; # TODO:
          # configurations = {}; # TODO:
          # settings = {}; # TODO:
          # signs = {}; # TODO:
        };

        # dap-python = {}; #?TODO:

        # dap-ui = {}; #?TODO:

      };
    };
}
