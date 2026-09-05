{ ... }:
let
  plugin_name = "which-key";
in
{
  flake.nixvimModules.${plugin_name} =
    { ... }:
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
            preset = "modern"; # false | "classic" | "modern" | "helix"

            replace = {
              desc = [
                [
                  "<space>"
                  "󱁐" # "SPACE"
                ]
                [
                  "<[cC][rR]>"
                  "󰌑" # "RETURN"
                ]
                [
                  "<[tT][aA][bB]>"
                  "" # TAB
                ]
                [
                  "<[bB][sS]>"
                  "󰁮" # "BACKSPACE"
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
                group = "[b]Buffers";
                icon = "󰓩 ";
                expand.__raw = ''
                  function() return require("which-key.extras").expand.buf() end
                '';
              }
              {
                __unkeyed-1 = "<leader>bs";
                group = "Sort";
                icon = "󰒺 ";
              }
              {
                __unkeyed = "<leader>c";
                group = "Codesnap";
                icon = "󰄄 ";
                mode = "v";
              }
              {
                __unkeyed = "<leader>c";
                group = "[c]code";
              }
              {
                __unkeyed-1 = "<leader>d";
                group = "[d]debug (trouble)";
              }
              {
                __unkeyed-1 = "<leader>f";
                group = "[f]find/files";
              }
              {
                __unkeyed-1 = "<leader>s";
                group = "[s]search/string";
              }
              {
                __unkeyed-1 = "<leader>u";
                group = "[u]ui/toggles";
              }
              {
                __unkeyed-1 = "<leader>w";
                group = "windows";
                proxy = "<C-w>";
                expand.__raw = ''
                  function() return require("which-key.extras").expand.win() end
                '';
                ## other builtins: (aka proxy?)
                ## - Marks on <`> <'>
                ## - Registars on <">(norm) <C-r>(ins)
                ## - Spelling on <z=>
                ## Also:
                ## motions, text-objects, operators, nav, z, and g (and more?)
              }

              ## END W LEADER

              {
                __unkeyed-1 = "Z";
                group = "[Z]zession"; # has ZZ(:wq) ZQ(:q!) ZR(:restart +qa!)
                mode = [ "n" ];
              }

              ## OTHER EXAMPLES

              # { __unkeyed-1 = [
              #     { __unkeyed-1 = "<leader>f"; group = "Normal Visual Group"; }
              #     { __unkeyed-1 = "<leader>f<tab>"; group = "Normal Visual Group in Group"; }
              #   ]; mode = [ "n" "v" ]; }

              # { __unkeyed-1 = "<leader>cS";
              #   __unkeyed-2 = "<cmd>CodeSnapSave<CR>";
              #   desc = "Save"; mode = "v"; }

              # { __unkeyed-1 = "<leader>db";
              #   __unkeyed-2.__raw = '' function() require("dap").toggle_breakpoint() end '';
              #   desc = "Breakpoint toggle"; mode = "n"; silent = true; }

            ];
            win = {
              border = "none"; # "single"
              no_overlap = true;
              wo = {
                winblend = 12; # 0-100 ; 100 fully transparent
              };
              # TEST
              # col.__raw = "math.floor(vim.o.columns * 0.2) ";
              # width.__raw = "math.floor(vim.o.columns * 0.6) ";
            };
          };
        };

      };
    };
}
