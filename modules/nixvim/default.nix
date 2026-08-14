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

      config = {
        # ## platforms -- HM-options
        # inherit enable;
        # defaultEditor = true;
        # vimdiffAlias = true;
        # nixpkgs.useGlobalPackages = true;

        # options -- neovim
        viAlias = true;
        vimAlias = true;
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
            enable = false; # Barely any differnce (~1ms ?)

            luaLib = true;
            # nvimRuntime = true;
            # plugins = true;
          };
          # combinePlugins = {enable = true;};
        };
      };

      # ## NOTE let nixvim handle colorscheme
      # stylix.targets.nixvim.enable = false;
    };
}
