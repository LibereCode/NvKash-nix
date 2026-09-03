{
  ...
}:
let
  plugin_name = "outline";
in
{
  flake.nixvimModules.${plugin_name} =
    {
      pkgs,
      ...
    }:
    {
      # ## INFO Outline.nvim is alternative to **Aerial.nvim** (I think...)
      # ## WARN Cant install because "norg treesitter" dependency fails?
      # extraPlugins = [
      #   (pkgs.vimUtils.buildVimPlugin {
      #     name = "outline";
      #     src = pkgs.vimPlugins.outline-nvim;
      #   })
      # ];
      # extraConfigLuaList = [
      #   # lua
      #   ''
      #     do
      #       -- INFO <https://github.com/hedyhli/outline.nvim/#recipes>
      #       local ol = require("outline")
      #       ol.setup({
      #         -- INFO Default <https://github.com/hedyhli/outline.nvim/#default-options>
      #         providers = {
      #           priority = { 'lsp',  'markdown', 'coc', 'man' }, -- 'norg',
      #         },
      #       })
      #
      #       local opts = {}
      #       vim.keymap.set("n", "<leader>T", function() ol.toggle(opts) end, { desc = "toggle [T]ouTline" })
      #     end
      #   ''
      # ];
    };
}
