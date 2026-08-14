{ inputs, ... }:
{
  imports = [
    # Import nixvim's flake-parts module;
    # Adds `flake.nixvimModules` and `perSystem.nixvimConfigurations`
    inputs.nixvim.flakeModules.default
  ];

  systems = [
    "x86_64-linux"
    "aarch64-linux"
    # "x86_64-darwin" #???
    "aarch64-darwin"
  ];

  nixvim = {
    # Automatically install corresponding packages for each nixvimConfiguration
    # Lets you run `nix run .#<name>`, or simply `nix run` if you have a default
    packages.enable = true;
    # Automatically install checks for each nixvimConfiguration
    # Run `nix flake check` to verify that your config is not broken
    checks.enable = true;
  };
}
