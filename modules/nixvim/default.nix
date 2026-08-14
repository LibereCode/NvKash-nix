{
  self,
  inputs,
  ...
}@top:
let
  moduleName = "default";
in
{
  flake.homeModules.${moduleName} =
    {
      pkgs,
      config,
      lib,
      ...
    }@a:
    let
      enable = config.my.modules.${moduleName}.enable;
      mkIf = lib.mkIf enable;
      lua = a.lib.nixvim.mkRaw;
    in
    {
      options.my.modules.${moduleName}.enable = a.lib.mkOption {
        default = true; # TODO # a.config.my.bundles.${bundleName}.enable;
        type = a.lib.types.bool;
        description = "Whether to enable {module}`${moduleName}`";
      };

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

      # config = top.lib.mkIf (config.my.nixvim.enable) {
      config = mkIf {
        # ## platforms -- HM-options
        # inherit enable;
        # defaultEditor = true;
        # vimdiffAlias = true;

        nixpkgs.useGlobalPackages = true;

        # options -- neovim
        viAlias = true;
        vimAlias = true;
        extraConfigLuaPost =
          # lua
          ''
            -- extraConfigLuaPost (nixvim)
            require("lua")
          '';

        globals = {
          mapleader = " ";
          localmapleader = "  ";
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
