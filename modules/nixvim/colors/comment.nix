{ self, inputs, ... }@top:
let
  plugin_name = "comment";
in
{
  flake.nixvimModules.${plugin_name} =
    { config, lib, ... }:
    {
      plugins = {
        ${plugin_name} = {
          enable = true;
          # settings = { }; # TODO:
        };

        todo-comments = {
          enable = true;
          # settings = { }; # TODO:

          luaConfig.post = ''
            ---todo-comments.nvim integrations with other plugins:
            ${lib.optionalString (config.plugins.trouble.enable) /* lua */ ''
              do
                ---TodoTrouble (trouble.nvim and todo-comments.nvim)
                vim.keymap.set('n', '<leader>dt', '<cmd>Trouble todo toggle<CR>', { desc = "Trouble: [t]todo"})
              end
            ''}
            ${lib.optionalString (config.plugins.trouble.enable) /* lua */ ''
              do
                ---TodoTelescope (telescope.nvim and todo-comments.nvim)
                vim.keymap.set('n', '<leader>st', '<cmd>Telescope todo-comments<CR>', { desc = "[t]todo-comments"})
              end
            ''}
          '';
        };

      };
    };
}
