{ self, inputs, ... }@top:
let
  pluginName = "nvim-autopairs";
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

          settings = {
            check_ts = true; # tree_sitter
            map_cr = true; # TEST: buggy?
            fast_wrap = { };
          };
          luaConfig.post = ''
            --TODO: Checkout [Custom Rules](https://github.com/windwp/nvim-autopairs/wiki/Custom-rules)
          '';
        };
      };
    };
}
