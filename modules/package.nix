{ inputs, self, ... }: {

  # See: <https://nix-community.github.io/nixvim/platforms/standalone.html#building-tests>

  perSystem =
    { system, ... }:
    {
      packages.${system}.default = self.nixvimConfigurations.default.config.build.package;
    };
}
