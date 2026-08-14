{ inputs, self, ... }: {

  # # You can define your reusable Nixvim modules here
  # flake.nixvimModules = {
  #   default = ./config;
  # };

  perSystem =
    { system, ... }:
    {
      # You can define actual Nixvim configurations here
      nixvimConfigurations = {
        default = inputs.nixvim.lib.evalNixvim {
          inherit system;
          #NOTE: import all nixvimModules
          modules = map (name: self.nixvimModules.${name}) (builtins.attrNames self.nixvimModules);
        };
      };
    };
}
