{ self, inputs, ... }@top:
let
  #XXX: RENAME TO PLUGIN'S NAME
  pluginName = "FOOBAR";
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
          enable = true;
        };
      };
    };
}
