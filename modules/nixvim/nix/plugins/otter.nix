{ self, inputs, ... }@top:
let
  pluginName = "otter";
in
{
  flake.homeModules.nixvim_plugins =
    {
      pkgs,
      config,
      lib,
      ...
    }@a:
    let
      inherit (lib.nixvim) mkRaw;
    in
    {
      plugins = {
        ${pluginName} = {
          enable = false; # FIXME: need better lsp use

          # settings = {};
        };
      };
    };
}
