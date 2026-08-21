{
  self,
  inputs,
  ...
}@top:
let
  moduleName = "default";
in
{
  flake.nixvimModules.${moduleName} =
    {
      pkgs,
      config,
      lib,
      ...
    }@a:
    let
      lua = a.lib.nixvim.mkRaw;
    in
    {

      /*
        =====================================================================
        ==========================  nixvim  btw ===========================
        =====================================================================
        ========                                    .-----.          ========
        ========         .----------------------.   | === |          ========
        ========         |.-""""""""""""""""""-.|   |-----|          ========
        ========         ||                    ||   | === |          ========
        ========         ||  Nixing the Vimma  ||   |-----|          ========
        ========         ||                    ||   | === |          ========
        ========         ||                    ||   |-----|          ========
        ========         ||:Tutor              ||   |:::::|          ========
        ========         |'-..................-'|   |____o|          ========
        ========         `"")----------------(""`   ___________      ========
        ========        /::::::::::|  |::::::::::\  \ no mouse \     ========
        ========       /:::========|  |==hjkl==:::\  \ required \    ========
        ========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
        ========                                                     ========
        =====================================================================
        =====================================================================
      */

      options =
        let
          inherit (lib) mkOption types;
        in
        {
          extraConfigLuaList = mkOption {
            default = [ ];
            type = types.listOf types.str;
            description = "A list of strings that will be merged to `extraConfigLua`";
          };
        };

      config = {
        # ## platforms -- HM-options
        # inherit enable;
        # defaultEditor = true;
        # vimdiffAlias = true;
        # nixpkgs.useGlobalPackages = true;

        # options -- neovim
        viAlias = true;
        vimAlias = true;
        extraConfigLua = (builtins.concatStringsSep "\n" config.extraConfigLuaList);
        extraConfigLuaPost =
          # lua
          ''
            -- extraConfigLuaPost (nixvim)
            require("lua")
            print("require('lua')")
          '';

        globals = {
          mapleader = " ";
          localmapleader = "<leader><leader>";
        };
        keymaps = [
          {
            key = "<localleader><leader>";
            action = "";
            options = {
              desc = "reset <leader>";
            };
          }
        ];

        clipboard = {
          register = "unnamedplus";
          providers.wl-copy = {
            enable = true;
            # package = pkgs.wl-clipboard-rs; # overlayed
          };
        };

        luaLoader.enable = true;
        performance = {
          byteCompileLua = {
            enable = false; # Roughly (on vs off): (ms) 90+-2 vs 97+-4

            luaLib = true;
            nvimRuntime = true;
            plugins = true;
          };
          # combinePlugins = {enable = true;};
        };
      };

      # ## NOTE let nixvim handle colorscheme
      # stylix.targets.nixvim.enable = false;
    };
}
