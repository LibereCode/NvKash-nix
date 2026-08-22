{
  self,
  inputs,
  ...
}:
{
  flake.nixvimModules.lua =
    { pkgs, lib, ... }@a:
    let
      #INFO: These 2 will produce (only with ./*.lua):
      ## extraFiles = { "after/ftplugin/foo.lua".source = ./foo.lua; ... }
      lua_files =
        with builtins;
        (filter (file: (match ".*(lua)$" "${file}") != null) (attrNames (readDir ./.)));
      extraFiles = lib.genAttrs' lua_files (
        file: lib.nameValuePair "ftplugin/${file}" { source = ./. + "/${file}"; }
      );
    in
    {
      # <https://nix-community.github.io/nixvim/NeovimOptions/extraFiles/index.html#extrafiles>
      inherit extraFiles;
    };
}
