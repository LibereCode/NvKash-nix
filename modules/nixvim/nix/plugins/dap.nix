{ self, inputs, ... }@top:
let
  plugin_name = "dap";
in
{
  flake.nixvimmodules.${plugin_name} =
    { pkgs, lib, ... }@a:
    let
      inherit (lib.nixvim) mkRaw;
    in
    {
      plugins = {
        ${plugin_name} = {
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
