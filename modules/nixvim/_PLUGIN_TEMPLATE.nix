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
      plugins
        # .CHANGE_ME # XXX: RENAME ME (I don't use the variable, because of nixd completions)
        = {
          # enable = true;
          #
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
          #
          # settings = {
          #
          # };
          #
          # luaConfig.post = ''
          #
          # '';
        };
    };
}
