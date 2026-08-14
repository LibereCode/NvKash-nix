{ self, inputs, ... }:
{

  flake.homeModules.nixvim_dependencies =
    { pkgs, ... }@args:
    {
      dependencies = builtins.listToAttrs (
        map
          (name: {
            inherit name;
            value = {
              enable = true;
              packageFallback = true;
            };
          })
          [
            "bat"
            "coreutils"
            "fd"
            "fzf"
            "git"
            "grep"
            "ripgrep"
            "sd"
            "sed"
            "tmux"
            "yazi"
            "yq"
          ]
      );
    };
}
