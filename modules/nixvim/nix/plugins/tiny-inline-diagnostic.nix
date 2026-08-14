{ self, inputs, ... }@top:
let
  pluginName = "tiny-inline-diagnostic";
in
{
  flake.homeModules.nixvim_plugins =
    {
      pkgs,
      config,
      lib,
      ...
    }@a:
    let
      inherit (lib.nixvim) mkRaw;
    in
    {
      plugins.${pluginName} = {
        enable = true;
        settings = {
          preset = "ghost"; # "minimal"|"classic"|"modern"|"ghost"|"amongus";
          options = {
            multilines = {
              enabled = true;
            };
            # use_icons_from_diagnostic = true;
            virt_texts = {
              priority = 2048;
            };
          };
        };
        luaConfig.post = /* lua */ ''
          -- Disable Neovim's default virtual text diagnostics
          vim.diagnostic.config({ virtual_text = false })
        '';
      };
    };
}
