{ ... }:
let
  pluginName = "neorg";
in
{
  flake.nixvimModules.plugins =
    { ... }:
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
              "core.defaults".__raw = "{}"; # __empty = null;
              "core.dirman".config = {
                workspaces = {
                  # work = "~/Notes/Work/noerg";
                  # home = "~/Notes/Home/noerg";
                  notes = "~/Notes/noerg";
                };
                default_workspace = "notes";
                index = "index.norg";
              };
              "core.concealer".config.icon_preset = "varied";
              "core.journal".config.workspace = "notes";
            };
            # logger = { };
          };

          # luaConfig.post = ''
          #
          # ''
        };
      };
      extraFiles."ftplugin/norg.lua".source = ./norg.lua;
    };
}
