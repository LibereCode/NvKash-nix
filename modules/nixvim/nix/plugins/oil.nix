{ self, inputs, ... }@top:
let
  plugin_name = "oil";
in
{
  flake.nixvimmodules.${plugin_name} =
    { pkgs, lib, ... }@a:
    let
      inherit (lib.nixvim) mkraw;
    in
    {
      plugins = {
        ${plugin_name} = {
          enable = true;

          luaConfig.pre = /* lua */ ''
            local oil = require("oil")
            local map = vim.keymap.set
            map('n', '<leader>O', function() oil.open(nil, { preview = { vertical = true } }) end, { desc = '󰏇 [O]il🦅' }) -- '<CMD>Oil<CR>'
            map('n', '<leader>e', function() oil.toggle_float() end, { desc = 'toggl[e]󰏇 OIL🦅' })
          '';

          settings = {
            default_file_explorer = true;

            columns = [ "icon" ];
            skip_confirm_for_simple_edits = true;
            delete_to_trash = true;

            view_options = {
              show_hidden = true;
            };

            preview_win = {
              preview_method = "scratch";
            };

            keymaps = {
              "q" = "actions.close";
              "<C-ESC>" = "actions.close";
              "<leader>O" = "actions.close"; # toggle
              "~" = "<cmd>edit $HOME<CR>";
              "<localleader>;" = "actions.open_cmdline"; # opts = { shorten_path = true; modify = ":h"; }; desc = ":ex-mode <cDir>";

              "<TAB>" = "actions.preview";
              # "<C-b>" = "actions.preview_scroll_left";
              "<C-d>" = "actions.preview_scroll_down";
              "<C-u>" = "actions.preview_scroll_up";
              # "<C-f>" = "actions.preview_scroll_right";

              "H" = "actions.parent";
              "L" = "actions.select";
              "K" = "actions.preview";
            };

          };
        };

      };
    };
}
