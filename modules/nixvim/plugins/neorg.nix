{ self, inputs, ... }@top:
let
  pluginName = "neorg";
in
{
  flake.nixvimModules.plugins =
    { lib, ... }@a:
    {
      plugins = {
        ${pluginName} = {
          enable = true;
          telescopeIntegration.enable = true;

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

          settings = {
            # hook.__raw = "";
            # lazy_loading 40
            load = {
              "core.concealer".config.icon_preset = "varied";
              "core.defaults".__empty = null;
              "core.dirman".config.workspaces = {
                home = "~/notes/home";
                work = "~/notes/work";
              };
            };
            # logger = { };
          };

          # luaConfig.post = ''
          #
          # ''
        };
      };
    };
}
