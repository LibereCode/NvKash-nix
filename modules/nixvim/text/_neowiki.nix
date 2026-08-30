{
  ...
}:
let
  plugin_name = "neowiki";
in
{
  flake.nixvimModules.${plugin_name} =
    {
      pkgs,
      ...
    }:
    {
      # extraPlugins = [
      #   (pkgs.vimUtils.buildVimPlugin {
      #     name = "neowiki";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "echaya";
      #       repo = "neowiki.nvim";
      #       tag = "v1.0";
      #       hash = "sha256-PXJhaX9pqIgDWZZbzK8z9SstW0kQ9SuB5IMPq7EjYic=";
      #     };
      #   })
      # ];
      # extraConfigLuaList = [
      #   # lua
      #   ''
      #     do
      #       -- INFO <https://github.com/echaya/neowiki.nvim#%EF%B8%8F-default-configuration>
      #       local nw = require("neowiki")
      #       nw.setup({
      #         wiki_dirs = {
      #           -- neowiki.nvim supports both absolute and tilde-expanded paths
      #           -- { name = "Work", path = "~/Documents/Notes/wiki/Work" },
      #           -- { name = "Personal", path = "~/Documents/Notes/wiki/Personal" },
      #           { name = "The_Wiki", path = "~/Documents/Notes/wiki" }, -- <- WARN IMPURE
      #         },
      #       })
      #       local map = vim.keymap.set
      #       map("n", "<leader>ow", nw.open_wiki, { desc = "open [w]wiki"})
      #       map("n", "<leader>oW", nw.open_wiki_floating, { desc = "Open [W]Wiki Floating"})
      #       map("n", "<leader>oT", nw.open_wiki_new_tab, { desc = "Open Wiki new [T]Tab"})
      #     end
      #   ''
      # ];
    };
}
