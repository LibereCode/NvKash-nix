{
  ...
}:
{
  flake.nixvimModules.options =
    { pkgs, ... }@a:
    let
      lua = a.lib.nixvim.mkRaw;
    in
    {
      config = {
        # NOTE See ./tiny-inline-diagnostic.nix
        diagnostic.settings = {
          update_in_insert = false;
          # severity_sort = false;

          float = {
            border = "rounded";
            source = "if_many";
          };
          underline.severity.min = lua "vim.diagnostic.severity.INFO";

          ## disable nvim default virtual_text (See ./tiny-inline-diagnostic.lua)
          virtual_text = false;
          virtual_lines = false;
          # virtual_text.virt_text_pos = "eol_right_align"; # `:h nvim_buf_set_extmark()`
          # virtual_lines = {
          #   current_line = true;
          #   severity.min = lua "vim.diagnostic.severity.WARN";
          # };

          jump.on_jump.__raw = "on_jump";
        };

        extraConfigLuaList = [
          (builtins.readFile ./init.lua)
        ];
      };
    };
}
