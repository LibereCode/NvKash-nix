{ self, inputs, ... }@top:
{

  # flake.homeModules.nixvim_plug_comment =
  flake.homeModules.nixvim_plugins =
    { pkgs, ... }@a:
    {
      plugins = {

        comment = {
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
