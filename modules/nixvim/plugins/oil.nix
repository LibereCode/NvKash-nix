{ self, inputs, ... }@top:
let
  plugin_name = "oil";
in
{
  flake.nixvimModules.${plugin_name} =
    { pkgs, lib, ... }@a:
    {
      plugins = {
        ${plugin_name} = {
          enable = true;

          settings = {
            default_file_explorer = true;

            columns = [ "icon" ]; # "permissions" "size" "mtime"
            skip_confirm_for_simple_edits = true;
            delete_to_trash = true;

            view_options = {
              show_hidden = true;
            };

            preview_win = {
              # -- vs 'scratch_fast' # very slow... -> "load" <-
              preview_method = "scratch";
            };

            keymaps = {
              "q" = "actions.close";
              "<C-q>" = {
                __unkeyed-1.__raw = ''function() require("oil").close() end '';
                desc = "oil🦅close";
              };
              # "<C-ESC>" = "actions.close";
              # "<leader>O" = "actions.close"; # toggle
              "~" = "<cmd>edit $HOME<CR>";
              "<localleader>;" = {
                __unkeyed-1 = "actions.open_cmdline";
                opts = {
                  shorten_path = true;
                  modify = ":h";
                };
                desc = ":ex-mode <cDir>";
              };

              # -- from docs `:h oil-actions`
              "<localleader>f" = {
                __unkeyed-1.__raw = ''
                  function()
                    require('telescope.builtin').find_files {
                      cwd = require('oil').get_current_dir(),
                    }
                  end
                '';
                mode = "n";
                nowait = true;
                desc = "[f]oil telescope";
              };

              "<TAB>" = "actions.preview";
              "<C-b>" = "actions.preview_scroll_left";
              "<C-d>" = "actions.preview_scroll_down";
              "<C-u>" = "actions.preview_scroll_up";
              "<C-f>" = "actions.preview_scroll_right";

              "H" = "actions.parent";
              "L" = "actions.select";
              "K" = "actions.preview";
            };

          };
          luaConfig.post = /* lua */ ''
            -- NOTE good practice to wrap in `do ... end` (keep scope local)
            do
              local oil = require("oil")
              local map = vim.keymap.set

              ---@class oil_.OpenExtraArgs
              ---@field dir? string `dir` to open
              ---@field opts? oil.OpenOpts See docs `:h opil.open`
              ---@field callback? fun() `callback` function when oil open

              ---@param extra oil_.OpenExtraArgs table of (optional) "dir" {opts} callback
              local function oil_toggle(extra)
                local oil_is_closed = vim.bo.ft ~= "oil"
                local extra = extra or {}
                local dir, opts, callback = extra.dir, extra.opts, extra.callback
                if oil_is_closed then
                  oil.open(dir, opts, callback)
                else
                  oil.close()
                end
              end

              -- map('n', '<leader>O', function() oil.open(nil, { preview = { vertical = true } }) end, { desc = '󰏇 [O]il🦅' }) -- '<CMD>Oil<CR>'
              map("n", "<M-e>", function() oil.toggle_float() end, { desc = "toggl[e]󰏇 OIL🦅 (float)" })
              map("n", "<leader>e", oil_toggle, { desc = "toggle󰏇 [O]il🦅" })
            end
          '';
        };

      };
    };
}
