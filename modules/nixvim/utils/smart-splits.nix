{
  ...
}:
let
  pluginName = "smart-splits";
in
{
  flake.nixvimModules.${pluginName} =
    {
      ...
    }:
    {
      plugins.smart-splits = {
        enable = true;

        ## Config: <https://github.com/mrjones2014/smart-splits.nvim#configuration>
        settings = {
          default_amount = 2; # 3 # lines/columns resized per action
          # ignored_events = [ "BufEnter" "WinEnter" ];
        };

        luaConfig.post = ''
          do -- smart-splits. See <https://github.com/mrjones2014/smart-splits.nvim#usage>
            local map = vim.keymap.set
            local smaspl = require("smart-splits")
            -- recommended mappings
            -- resizing splits
            -- these keymaps will also accept a range,
            -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
            map('n', '<A-S-h>', smaspl.resize_left)
            map('n', '<A-S-j>', smaspl.resize_down)
            map('n', '<A-S-k>', smaspl.resize_up)
            map('n', '<A-S-l>', smaspl.resize_right)
            -- moving between splits
            map('n', '<C-h>', smaspl.move_cursor_left)
            map('n', '<C-j>', smaspl.move_cursor_down)
            map('n', '<C-k>', smaspl.move_cursor_up)
            map('n', '<C-l>', smaspl.move_cursor_right)
            map('n', '<C-\\>', smaspl.move_cursor_previous)
            -- -- swapping buffers between windows -- XXX nvim-builtins are better
            -- map('n', '<C-A-h>', smaspl.swap_buf_left)
            -- map('n', '<C-A-j>', smaspl.swap_buf_down)
            -- map('n', '<C-A-k>', smaspl.swap_buf_up)
            -- map('n', '<C-A-l>', smaspl.swap_buf_right)
            map('n', '<C-A-h>', "<C-w>H")
            map('n', '<C-A-j>', "<C-w>J")
            map('n', '<C-A-k>', "<C-w>K")
            map('n', '<C-A-l>', "<C-w>L")

          end

        '';
      };
    };
}
