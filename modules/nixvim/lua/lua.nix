{
  self,
  inputs,
  ...
}:
{
  flake.homeModules.nixvim_lua =
    { pkgs, ... }@a:
    {
      # <https://nix-community.github.io/nixvim/NeovimOptions/index.html#files>
      files = {
        # "lua/lua.lua".extraConfigLua = /* lua */ ''
        #   require("mappings")
        #   require("options")
        #   require("autocmds")
        # '';
      };

      # <https://nix-community.github.io/nixvim/NeovimOptions/extraFiles/index.html#extrafiles>
      extraFiles = {
        "lua/lua.lua".text =
          # lua
          ''
            require("mappings")
            require("options")
            require("autocmds")
          '';

        "lua/mappings.lua".source = ./mappings.lua;

        "lua/options.lua".source = ./options.lua;

        "lua/autocmds.lua".source = ./autocmds.lua;
      };
    };
}
