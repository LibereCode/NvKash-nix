{ ... }:
let
  moduleName = "aaaaaa";
in
{
  flake.nixosModules.${moduleName} =
    {
      config,
      lib,
      ...
    }:
    let
      enableIf = lib.mkIf config.my.modules.${moduleName}.enable;
    in
    {
      config = enableIf {
        programs.aaaaaa = {
          enable = true;
          foo = "bar";
        };
      };
    };
}
