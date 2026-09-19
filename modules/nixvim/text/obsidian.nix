{ ... }:
let
  pluginName = "obsidian";
in
{
  flake.nixvimModules.${pluginName} =
    { ... }:
    let
      workspacesDir = "~/Notes/obsidian";
    in
    {
      plugins = {
        obsidian = {
          enable = true;

          ## Default: <https://github.com/obsidian-nvim/obsidian.nvim/blob/main/lua/obsidian/config/default.lua>
          ## 󱞪 (RAW): [./_obsidian-default.lua](https://raw.githubusercontent.com/obsidian-nvim/obsidian.nvim/refs/heads/main/lua/obsidian/config/default.lua)
          settings = {
            legacy_commands = false;
            picker.name = "telescope.nvim";

            new_notes_location = "current_dir";
            workspaces = [
              {
                name = "projects";
                path = "${workspacesDir}/projects";
              }
            ];
            checkbox.order = [
              " "
              "-"
              "x"
              # "?"
              # "!"
              # "+"
              # "="
            ];
          };

          luaConfig = {
            pre = # lua
              ''
                ---`plugins.obsidian.luaConfig.pre`
                do
                  ---Could be inline, but this gives better syntax-highlighting...
                  ---Base directory of where to keep obsidian-vaults.
                  local workspacesDir = [[${workspacesDir}]]
                  ---INFO Fixes "directory doesn't exist" error (especially during `nix flake check`)
                  vim.fn.mkdir(vim.fn.expand(workspacesDir.."/projects"), "p" )
                end
              '';
          };
        };
      };
    };
}
