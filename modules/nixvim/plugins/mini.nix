{ self, inputs, ... }@top:
let
  plugin_name = "mini";
in
{
  flake.nixvimModules.${plugin_name} =
    { pkgs, lib, ... }@a:
    let
      inherit (lib.nixvim) mkraw;
    in
    {
      plugins.${plugin_name} = {
        enable = true;
        mockDevIcons = true;

        modules = {
          # around/inside
          ai = {
            n_lines = 50;
            search_method = "cover_or_next";
          };
          # comment
          comment = {
            mappings = {
              comment = "<leader>/";
              comment_line = "<leader>/";
              comment_visual = "<leader>/";
              textobject = "<leader>/";
            };
          };
          # nvim [-d|--diff]
          diff = {
            view = {
              style = "sign";
            };
          };
          # dev-icons
          icons = { };
          # surround
          surround = {
            mappings = {
              add = "gsa";
              delete = "gsd";
              find = "gsf";
              find_left = "gsF";
              highlight = "gsh";
              replace = "gsr";
              update_n_lines = "gsn";
            };
          };
          move = {
            mappings = {
              # VISUAL -- defaults = Alt(M) + hjkl
              left = "<M-h>";
              down = "<M-j>";
              up = "<M-k>";
              right = "<M-l>";

              # NORMAL -- defaults = Alt(M) + hjkl
              line_left = "<M-h>";
              line_down = "<M-j>";
              line_up = "<M-k>";
              line_right = "<M-l>";
            };
            options.reindent_linewise = true;
          };
        };
      };
    };
}
