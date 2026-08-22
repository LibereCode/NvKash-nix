{
  self,
  inputs,
  ...
}:
{
  flake.nixvimModules.lua =
    { lib, config, ... }@a:
    {
      options =
        let
          inherit (lib) mkOption;
          inherit (lib.types) listOf str attrs;
        in
        {
          extraConfigLuaList = mkOption {
            default = [ ];
            type = listOf str;
            description = "A list of strings that will be merged to `extraConfigLua`";
          };
        };

      config =
        let
          # lua_files = [ "mappings" "options" "autocmds" ];
          files_lua = builtins.filter (name: lib.hasPrefix "lua/" name) (builtins.attrNames config.files);
          files_lua_strip = map (name: lib.removeSuffix ".lua" (lib.removePrefix "lua/" name)) files_lua;
        in
        with builtins;
        {
          extraConfigLua = (concatStringsSep "\n" config.extraConfigLuaList);
          extraConfigLuaPost = ''
            -- extraConfigLuaPost (nixvim):
            --[[
              ```nix
              files_lua = builtins.filter (name: lib.hasPrefix "lua/" name) (builtins.attrNames config.files);
              files_lua_strip = map (name: lib.removeSuffix ".lua" (lib.removePrefix "lua/" name)) files_lua;
              ```
            ]]
          ''
          + concatStringsSep "\n" (map (file: /* lua */ "require('${file}')") files_lua_strip);

          ## See: <https://nix-community.github.io/nixvim/NeovimOptions/index.html#files>
          files = lib.genAttrs' [ "mappings" "options" "autocmds" ] (
            file: lib.nameValuePair "lua/${file}.lua" { extraConfigLua = readFile (./. + "/${file}.lua"); }
          );

          ## See: <https://nix-community.github.io/nixvim/NeovimOptions/extraFiles/index.html#extrafiles>
          ## extraFiles.<file>.text <=> files.<file>.extraConfigLua
          ## {extraFiles.<file>.source = ./<file>;} <=> {files.<file>.extraConfigLua = builtins.readFile ./<file>;}
          # extraFiles = { };
        };
    };
}
