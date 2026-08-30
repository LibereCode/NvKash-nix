{
  ...
}:
let
  pluginName = "dap";
in
{
  flake.nixvimModules.plugins =
    {
      pkgs,
      ...
    }:
    {
      extraPlugins = [
        ## INFO Dependency
        (pkgs.vimUtils.buildVimPlugin {
          name = "nvim-nio";
          src = pkgs.vimPlugins.nvim-nio;
        })
      ];

      plugins = {
        ${pluginName} = {
          enable = true;
          configurations = {
            ## <https://nix-community.github.io/nixvim/plugins/dap/index.html#pluginsdapconfigurations>
            # cpp = [
            # ];
            # settings = {
            # };
            # adapters = {}; # TODO
            # signs = {}; # TODO
          };
        };
        # dap-python = {}; #?TODO?
        # dap-ui = {}; #?TODO?

        dap-ui = {
          enable = true;
          settings = {
            layouts = [
              {
                elements = [
                  ## From example
                  {
                    id = "scopes";
                    size = 0.25;
                  }
                  {
                    id = "breakpoints";
                    size = 0.25;
                  }
                  {
                    id = "stacks";
                    size = 0.25;
                  }
                  {
                    id = "watches";
                    size = 0.25;
                  }
                ];
                position = "left";
                size = 40;
              }
              {
                elements = [
                  {
                    id = "repl";
                    size = 0.5;
                  }
                  {
                    id = "console";
                    size = 0.5;
                  }
                ];
                position = "bottom";
                size = 10;
              }
            ];
          };
          luaConfig.post = ''
            do
              local dapui = require("dapui")
              vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "toggle dap[u]ui"})
            end
          '';
        };
      };
    };
}
