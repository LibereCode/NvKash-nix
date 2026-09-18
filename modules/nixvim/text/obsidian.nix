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
          };

          luaConfig = {
            pre = ''
              ---`plugins.obsidian.luaConfig.post`
              do
                ---INFO Fixes "directory doesn't exist" error (especially during `nix flake check`)
                vim.fn.mkdir(vim.fn.expand("${workspacesDir}/projects"), "p" )
              end
            '';
          };
        };
      };
    };
}
