{ ... }:
let
  pluginName = "obsidian";
in
{
  flake.nixvimModules.${pluginName} =
    { ... }:
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
                path = "~/Notes/obsidian/projects";
              }
            ];
          };

          # luaConfig.post = #TODO: This format in all `plugins.<plug>.luaConfig.<pos>`
          #   ''
          #     ---`plugins.obsidian.luaConfig.post`
          #     do
          #     end
          #   '';
        };
      };
    };
}
