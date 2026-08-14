{ self, inputs, ... }@top:
{

  # flake.homeModules.nixvim_plug_which-key =
  flake.homeModules.nixvim_plugins =
    { pkgs, ... }@a:
    {
      plugins = {

        which-key = {
          enable = true;
          # TODO: somehow add mappings. via luaConfig?
          # luaConfig = ''
          # '';
          settings = {
            delay = 200;
            expand = 1;
            notify = false;
            preset = false;
            replace = {
              desc = [
                [
                  "<space>"
                  "SPACE"
                ]
                [
                  "<[cC][rR]>"
                  "" # "RETURN"
                ]
                [
                  "<[tT][aA][bB]>"
                  "TAB"
                ]
                [
                  "<[bB][sS]>"
                  "BACKSPACE"
                ]
                [
                  "<[Cc][Mm][Dd]>"
                  ":"
                ]
              ];
            };
            spec = [
              {
                __unkeyed-1 = "<leader>b";
                group = "Buffers";
                icon = "󰓩 ";
              }
              {
                __unkeyed = "<leader>c";
                group = "Codesnap";
                icon = "󰄄 ";
                mode = "v";
              }
              {
                __unkeyed-1 = "<leader>bs";
                group = "Sort";
                icon = "󰒺 ";
              }
              {
                __unkeyed-1 = [
                  {
                    __unkeyed-1 = "<leader>f";
                    group = "Normal Visual Group";
                  }
                  {
                    __unkeyed-1 = "<leader>f<tab>";
                    group = "Normal Visual Group in Group";
                  }
                ];
                mode = [
                  "n"
                  "v"
                ];
              }
              {
                __unkeyed-1 = "<leader>w";
                group = "windows";
                proxy = "<C-w>";
              }
              # {
              #   __unkeyed-1 = "<leader>cS";
              #   __unkeyed-2 = "<cmd>CodeSnapSave<CR>";
              #   desc = "Save";
              #   mode = "v";
              # }
              # {
              #   __unkeyed-1 = "<leader>db";
              #   __unkeyed-2 = {
              #     __raw = ''
              #       function()
              #         require("dap").toggle_breakpoint()
              #       end
              #     '';
              #   };
              #   desc = "Breakpoint toggle";
              #   mode = "n";
              #   silent = true;
              # }
            ];
            win = {
              border = "single";
            };
          };
        };

      };
    };
}
