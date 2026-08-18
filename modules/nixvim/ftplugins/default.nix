{
  self,
  inputs,
  ...
}:
{
  flake.nixvimModules.lua =
    { pkgs, lib, ... }@a:
    let
      extraFiles = lib.mergeAttrsList (
        map (file: { "after/ftplugin/${file}".source = ./. + "/${file}"; }) (
          builtins.filter (file: (builtins.match ".*(lua)$" "${file}") != null) (
            builtins.attrNames (builtins.readDir ./.)
          )
        )
      );
    in
    {
      # <https://nix-community.github.io/nixvim/NeovimOptions/extraFiles/index.html#extrafiles>
      inherit extraFiles;
    };
}
