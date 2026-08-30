{ self, inputs, ... }@top:
let
  plugin_name = "markdown";
in
{
  flake.nixvimModules.${plugin_name} =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      plugins = {
        ## [See `render-markdown` docs](https://github.com/MeanderingProgrammer/render-markdown.nvim/tree/main#setup)
        "render-${plugin_name}" = {
          enable = true;
          settings = {
            completions = {
              lsp.enabled = true;
              # TEST:
              # blink.enabled = true;
            };
            preset = "obsidian"; # obsidian|lazy|none
            # callout = {}; #TODO: [configure things like: `[!TIP]`](https://github.com/MeanderingProgrammer/render-markdown.nvim/blob/main/doc/render-markdown.txt#L820)
            # link.custom = {}; #TODO: [configure things like: icon for ^https://....](https://github.com/MeanderingProgrammer/render-markdown.nvim/blob/main/doc/render-markdown.txt#L820)
          };
        };

        ## [See `markdown-preview` docs](https://github.com/iamcco/markdown-preview.nvim/#markdownpreview-config)
        "${plugin_name}-preview" = {
          enable = true;
          settings = {
            auto_close = 1;
            auto_start = 0;
            browser = config.my.apps.browser.name or "${lib.getExe pkgs.librewolf}";
            echo_preview_url = 1;
            # highlight_css = mkRaw "vim.fn.expand('~/highlight.css')";
            page_title.__raw = ''
              "MD-preview: " .. vim.fn.pathshorten(os.getenv("PWD"), 2) .. "/''${name}"
            '';
            port = "13416"; # m=13 d=4 p=16
            preview_options = {
              disable_filename = 0;
              disable_sync_scroll = 0;
              sync_scroll_type = "middle";
            };
            theme = "dark";
          };
        };
      };
      # extraConfigLuaList = [
      #   # lua
      #   ''
      #     do
      #       -- -- WARN Doesnt work ):
      #       -- vim.api.nvim_create_autocmd('FileType', {
      #       --     group = vim.api.nvim_create_augroup("FileType_MarkdownPreview", {clear = true }),
      #       --     desc = "Autocmd for markdown-preview plugin. Set mappings and so.",
      #       --     pattern = "markdown",
      #       --     callback = function(ev)
      #       --       vim.keymap.set("n", "<localleader>p", "<CMD>MarkdownPreview<CR>")
      #       --     end,
      #       --   })
      #     end
      #   ''
      # ];

      ## WARN Do not work (freezes)
      # extraPlugins = [
      #   (pkgs.vimUtils.buildVimPlugin {
      #     name = "livepreview";
      #     src = pkgs.vimPlugins.live-preview-nvim;
      #   })
      # ];
      # extraConfigLuaList = [
      #   # lua
      #   ''
      #     do
      #       ---NOTE live-preview-nvim
      #       ---See :h livepreview
      #       require("livepreview.config").set({
      #         port = 12980, -- 5500
      #         browser = 'librewolf', -- 'default',
      #         dynamic_root = true,
      #         sync_scroll = false,
      #         picker = "telescope",
      #         address = '127.0.0.1',
      #       })
      #     end
      #   ''
      # ];
    };
}
