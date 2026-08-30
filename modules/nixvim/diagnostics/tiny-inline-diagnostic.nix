{ self, inputs, ... }@top:
let
  pluginName = "tiny-inline-diagnostic";
in
{
  flake.nixvimModules.plugins =
    { lib, ... }@a:
    let
      inherit (lib.nixvim) mkRaw;
    in
    {
      plugins.${pluginName} = {
        enable = true;
        settings = {
          ## Either preset ...
          # preset = "ghost"; # "ghost"|"amongus"|"minimal"|"classic"|"modern"|"powerline"|"nonerdfont";
          ## ... OR custom a style:
          signs = {
            left = "";
            right = "";
            diag = ""; #     󰊠  ●
            arrow = " <- ";
            up_arrow = " ⮬ ";
            vertical = " │";
            vertical_end = " └";
          };
          blend.factor = 0.05;

          transparent_cursorline = false;

          options = {
            add_messages = {
              messages = false;
              display_count = true;
              use_max_severity = true;
            };

            multilines.enabled = true;

            virt_texts.priority = 2048;

            # show_source.if_many = true;

            show_related.enabled = false; # TEST:
          };
        };
      };
    };
}
