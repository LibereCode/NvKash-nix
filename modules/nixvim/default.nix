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
          inherit (lib) mkOption;
          inherit (lib.types) listOf str;
        in
        {
          extraConfigLuaList = mkOption {
            default = [ ];
            type = listOf str;
            description = ''
              A list of strings that will be merged to `extraConfigLua`
              See its use in
            '';
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

        extraConfigLuaPre = ''
          -- Leader (+ local + reset)
          vim.g.mapleader = " "
          vim.g.maplocalleader = vim.keycode("<leader>") .. " "
          vim.keymap.set("", "<localleader><leader>", "", { desc = "reset <leader>" })
        '';
        extraConfigLua = (builtins.concatStringsSep "\n" config.extraConfigLuaList);
        # extraConfigLuaPost = ""; # See ./lua/lua.nix

        clipboard = {
          register = "unnamedplus";
          providers.wl-copy = {
            enable = true;
            # package = pkgs.wl-clipboard-rs; # overlayed
          };
        };

        # ## enable lazy loading
        plugins.lz-n = {
          enable = true;
        };

        luaLoader.enable = true;
        performance = {
          byteCompileLua = {
            enable = true; # Roughly (on vs off): (ms) 90+-2 vs 97+-4

            #XXX: These screw up lua_ls
            ## (Solution would be to figure out how to source pre-compiled src ...)
            luaLib = false;
            nvimRuntime = false;
            plugins = false;
          };
          # combinePlugins = {enable = true;};
        };
      };

      # ## NOTE let nixvim handle colorscheme
      # stylix.targets.nixvim.enable = false;
    };
}
