{
  ...
}:
let
  pluginName = "neogen";
in
{
  flake.nixvimModules.${pluginName} =
    {
      ...
    }:
    {
      plugins.neogen = {
        enable = true;

        settings = {
          snippet_engine = "luasnip";
          # languages = {}; # overwriting default settings
        };

        ## Garbage documentation lol
        ## WARN and didn't even work...
        keymaps = {
          generate = "<leader>cg";
          # generate_Class_File_Function_Type = "Also exist";
        };

        # luaConfig.post = ''
        #
        # '';
      };
    };
}
