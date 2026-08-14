{ self, inputs, ... }@top:
let
  plugin_name = "comment";
in
{
  flake.nixvimModules.${plugin_name} =
    { pkgs, ... }@a:
    {
      plugins = {
        ${plugin_name} = {
          enable = true;
          # settings = { }; # TODO:
        };

        todo-comments = {
          enable = true;
          # settings = { }; # TODO:
        };

      };
    };
}
