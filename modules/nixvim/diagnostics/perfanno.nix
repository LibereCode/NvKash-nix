{
  ...
}:
let
  pluginName = "perfanno";
in
{
  flake.nixvimModules.plugins =
    {
      lib,
      ...
    }:
    {
      plugins = {
        #TEST:
        ${pluginName} = {
          enable = true;
          settings = {
            annotate_after_load = true;
            annotate_on_open = true;
            formats = [
              {
                format = "%.2f%%";
                minimum = 0.5;
                percent = true;
              }
              {
                format = "%d";
                minimum = 1;
                percent = false;
              }
            ];
            line_highlights = lib.nixvim.mkRaw "require('perfanno.util').make_bg_highlights(nil, '#CC3300', 10)";
            telescope = {
              annotate = true;
              enabled = lib.nixvim.mkRaw "pcall(require, 'telescope')";
            };
            ts_function_patterns = {
              default = [
                "function"
                "method"
              ];
            };
            vt_highlight = lib.nixvim.mkRaw "require('perfanno.util').make_fg_highlight('#CC3300')";
          };
        };
      };
    };
}
