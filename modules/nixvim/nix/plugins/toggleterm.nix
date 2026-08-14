{ self, inputs, ... }@top:
let
  pluginName = "toggleterm";
in
{
  # flake.homeModules."nixvim_plug_${pluginName}" =
  flake.nixvimModules.plugins =
    { pkgs, config, ... }@a:
    let
      lua = a.lib.nixvim.mkRaw;
    in
    {
      plugins = {
        ${pluginName} = {
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
                    return 0.8
                  end
                end
              '';
            open_mappings = "[[<C-\\>]]";
          };

          luaConfig.post = # lua
            ''
              vim.keymap.set({"n", "t"}, "<M-t>", "<CMD>ToggleTerm<CR>", {})
            '';
        };
      };
    };
}
