{ self, inputs, ... }@top:
let
  pluginName = "luasnip";
in
{
  flake.nixvimModules.plugins =
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
      plugins.friendly-snippets.enable = true;

      plugins.${pluginName} = {
        enable = true;
        fromLua = [
          {
            paths = ./.;
            include = [ ".*[.]lua" ];
          }
        ];
      };
    };
}
