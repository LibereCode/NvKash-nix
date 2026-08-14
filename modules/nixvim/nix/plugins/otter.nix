{ self, inputs, ... }@top:
let
  plugin_name = "otter";
in
{
  flake.nixvimModules.${plugin_name} =
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
        ${plugin_name} = {
          enable = false; # FIXME: need better lsp use

          # settings = {};
        };
      };
    };
}
