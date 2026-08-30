{
  ...
}:
let
  #XXX: RENAME TO PLUGIN'S NAME
  pluginName = "FOOBAR";
in
{
  flake.nixvimModules.${pluginName} =
    {
      ...
    }:
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
