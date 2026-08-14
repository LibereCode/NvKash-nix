{ self, inputs, ... }@top:
{

  flake.homeModules.nixvim_plugins =
    { pkgs, ... }@a:
    let
      lua = a.lib.nixvim.mkRaw;
    in
    {
      # imports = with self.homeModules; [
      #   # ===================
      #   #         code
      #   # ===================
      #   nixvim_plug_blink
      #   nixvim_plug_conform
      #   # nixvim_plug_dap # TODO:
      #   nixvim_plug_dial
      #   # nixvim_plug_tmux # TODO:
      #   # nixvim_plug_trouble # TODO:
      #   # nixvim_plug_undotree # TODO:
      #
      #   # ===================
      #   #         ui
      #   # ===================
      #   nixvim_plug_bufferline
      #   nixvim_plug_colorizer
      #   nixvim_plug_comment
      #   nixvim_plug_colorizer
      #   nixvim_plug_lualine # TODO:
      #   nixvim_plug_treesitter
      #   nixvim_plug_which-key
      #
      #   # ===================
      #   #       movin'
      #   # ===================
      #   nixvim_plug_flash
      #   nixvim_plug_oil
      #   nixvim_plug_telescope
      #   # nixvim_plug_yazi #?TODO:
      #
      #   # ===================
      #   #        misc
      #   # ===================
      #   nixvim_plug_mini
      # ];

      plugins = {

      };
    };
  # };
}
