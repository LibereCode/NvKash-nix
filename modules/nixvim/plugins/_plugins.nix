{ self, inputs, ... }@top:
let
  #XXX: RENAME TO PLUGIN'S NAME
  pluginName = "FOOBAR";
in
{
  flake.nixvimModules.plugins =
    {
      pkgs,
      lib,
      config,
      ...
    }@a:
    # let
    #   inherit (lib.nixvim) mkRaw;
    # in
    {
      plugins = {
        ${pluginName} = {
          enable = true;

          # lazyLoad.settings = {
          #   cmd = "Foobar";
          #   keys = [
          #     {
          #       __unkeyed-1 = "<leader>idk";
          #       __unkeyed-3 = "<CMD>Foobar sub<CR>";
          #       desc = "Foo bar";
          #     }
          #   ];
          # };

          # settings = {
          #
          # };

          # luaConfig.post = ''
          #
          # ''
        };
      };
    };
}
