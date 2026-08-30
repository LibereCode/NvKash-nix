{
  ...
}:
let
  pluginName = "neotest";
in
{
  flake.nixvimModules.plugins =
    {
      ...
    }:
    {
      plugins = {
        ${pluginName} = {
          enable = true;
          adapters = {
            bash.enable = true;
            ctest.enable = true; # c
            plenary.enable = true; # plenary.nvim ?
            python.enable = true;
            rust.enable = true;
            zig.enable = true;
          };
          settings = {
            output = {
              enabled = true;
              open_on_run = true;
            };
            output_panel = {
              enabled = true;
              open = "botright split | resize 15";
            };
            quickfix = {
              enabled = true;
            };
            status = {
              virtual_text = true; # TEST
            };
            summary = {
              # mappings = {
              # <https://nix-community.github.io/nixvim/plugins/neotest/settings/summary.html#pluginsneotestsettingssummarymappings>
              # };
            };
          };
        };
      };
    };
}
