{ self, inputs, ... }@top:
let
  plugin_name = "toggleterm";
in
{
  flake.nixvimModules.${plugin_name} =
    { pkgs, config, ... }@a:
    let
      lua = a.lib.nixvim.mkRaw;
    in
    {
      plugins = {
        ${plugin_name} = {
          enable = true;

          settings = {
            direction = "float";
            float_opts = {
              border = "curved";
              # height = 80;
              # width = 30;
            };
            size = # lua
              ''
                function(term)
                  if term.direction == "horizontal" then
                    return 15
                  elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                  else
                    return 0.9
                  end
                end
              '';
            open_mappings = "[[<localleader>t]]"; # TEST:
          };

          luaConfig.post = # lua
            ''
              local Terminal  = require('toggleterm.terminal').Terminal
              local term_base = Terminal:new({hidden = true})
              local function termToggle() term_base:toggle() end

              -- vim.keymap.set({"n", "t"}, "<M-t>", "<CMD>ToggleTerm<CR>", {})
              vim.keymap.set({"n", "t"}, "<M-t>", termToggle, {})

              -- see ./git.nix for a use of toggleterm with lazygit
            '';
        };
      };
    };
}
