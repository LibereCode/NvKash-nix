{ inputs, self, ... }: {

  # See: <https://nix-community.github.io/nixvim/platforms/standalone.html#building-tests>

  perSystem =
    { system, ... }:
    {
      checks.${system}.default = self.nixvimConfigurations.default.config.build.test;

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
