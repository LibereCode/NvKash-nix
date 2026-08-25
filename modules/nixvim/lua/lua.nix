{
  self,
  inputs,
  ...
}:
{
  flake.nixvimModules.lua =
    { lib, config, ... }@a:
    {

      config =
        let
          lua_dir_files = builtins.attrNames (
            lib.filterAttrs (n: v: lib.hasSuffix ".lua" n && v == "regular") (builtins.readDir ./.)
          );
          files = lib.genAttrs' lua_dir_files (
            name: lib.nameValuePair ("lua/" + name) { extraConfigLua = builtins.readFile (./. + "/${name}"); }
          );

          files_lua = builtins.filter (name: lib.hasPrefix "lua/" name) (builtins.attrNames config.files);
          files_lua_strip = map (name: lib.removeSuffix ".lua" (lib.removePrefix "lua/" name)) files_lua;
        in
        with builtins;
        {
          extraConfigLuaPost = ''
            -- extraConfigLuaPost (nixvim):
            --[[
              ```nix
              lua_dir_files = builtins.attrNames (
                lib.filterAttrs (n: v: lib.hasSuffix ".lua" n && v == "regular") (builtins.readDir ./.)
              );
              files = lib.genAttrs' lua_dir_files (
                name: lib.nameValuePair ("lua/" + name) { extraConfigLua = builtins.readFile (./. + "/$<name>"); }
              );

              files_lua = builtins.filter (name: lib.hasPrefix "lua/" name) (builtins.attrNames config.files);
              files_lua_strip = map (name: lib.removeSuffix ".lua" (lib.removePrefix "lua/" name)) files_lua;
              ```
            ]]
          ''
          + concatStringsSep "\n" (map (file: /* lua */ "require('${file}')") files_lua_strip);

          inherit files;
          ## See: <https://nix-community.github.io/nixvim/NeovimOptions/index.html#files>
          # files = lib.genAttrs' [ "mappings" "options" "autocmds" ] (
          #   file: lib.nameValuePair "lua/${file}.lua" { extraConfigLua = readFile (./. + "/${file}.lua"); }
          # );

          ## See: <https://nix-community.github.io/nixvim/NeovimOptions/extraFiles/index.html#extrafiles>
          ## extraFiles.<file>.text <=> files.<file>.extraConfigLua
          ## {extraFiles.<file>.source = ./<file>;} <=> {files.<file>.extraConfigLua = builtins.readFile ./<file>;}
          # extraFiles = { };
        };
    };
}
