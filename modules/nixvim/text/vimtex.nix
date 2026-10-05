{ ... }:
let
  module_name = "latex";
in
{
  flake.nixvimModules.${module_name} =
    {
      pkgs,
      ...
    }:
    {
      plugins = {
        ## [See `vimtex` docs](https://github.com/lervag/vimtex#configuration)
        vimtex = {
          enable = true;
          # WARN Default texlive (texliveMedium) is ~= 1.7 GiB, and it is required...
          # texlivePackage = pkgs.texliveMedium;
          settings = {
            # compiler_method = "latexrun";
            # toc_config = «thunk»;
            # view_method = "zathura";
          };
        };
      };
    };
}
