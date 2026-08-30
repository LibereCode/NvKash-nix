{ self, inputs, ... }@top:
let
  plugin_name = "otter";
in
{
  flake.nixvimModules.${plugin_name} =
    {
      ...
    }:
    {
      plugins = {
        ${plugin_name} = {
          enable = true;

          autoActivate = false;
          #XXX: Really many errors. Instead activate on:
          ## :OtterActivate

          # settings = {};

          luaConfig.post = ''
            do -- otter.nvim
              local ott = require("otter")
              local ott_is_on = false

              vim.keymap.set("n", "<leader>lo", function()
                  local langs =  {
                    "lua", "python", "bash",
                    "sh", "fish","zsh", "c"
                  }
                  if not ott_is_on then
                    ott.activate(langs,true,true,nil)
                  else
                    ott.deactivate (false,false)
                  end
                  ott_is_on = not ott_is_on
              end, {desc = "toggle [o]otter"})

            end
          '';
        };
      };
    };
}
