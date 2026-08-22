{ inputs, ... }:
{
  imports = [
    # Import nixvim's flake-parts module;
    # Adds `flake.nixvimModules` and `perSystem.nixvimConfigurations`
    inputs.nixvim.flakeModules.default
  ];

  systems = [
    "x86_64-linux"

    ## Not available on nixpkgs-unstable(26.11)
    # "x86_64-darwin"

    ## no wayland support?
    # "aarch64-linux"
    # "aarch64-darwin"
  ];

  #INFO: from (experimental) flake-parts module
  nixvim = {
    # Automatically install corresponding packages for each nixvimConfiguration
    # Lets you run `nix run .#<name>`, or simply `nix run` if you have a default
    packages.enable = true;
    # REPLACES: ` packages.${system}.default = configuration.config.build.package; `

    # Automatically install checks for each nixvimConfiguration
    # Run `nix flake check` to verify that your config is not broken
    checks.enable = true;
    # REPLACES: ` checks.${system}.default = configuration.config.build.test; `
  };
}
